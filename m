Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132416AbREEMYr>; Sat, 5 May 2001 08:24:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132425AbREEMY2>; Sat, 5 May 2001 08:24:28 -0400
Received: from pizda.ninka.net ([216.101.162.242]:37779 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S132422AbREEMYW>;
	Sat, 5 May 2001 08:24:22 -0400
From: "David S. Miller" <davem@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15091.61684.880418.627960@pizda.ninka.net>
Date: Sat, 5 May 2001 05:24:20 -0700 (PDT)
To: gabriel <linuxkernel@blueyonder.co.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.4 rwsem make error
In-Reply-To: <3AF3EBF9.104C78F8@blueyonder.co.uk>
In-Reply-To: <3AF3EBF9.104C78F8@blueyonder.co.uk>
X-Mailer: VM 6.75 under 21.1 (patch 13) "Crater Lake" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


gabriel writes:
 > When I compiled bzImage (using .config from 2.2.3) I got the following
 > errors:

You have to run oldconfig to add the proper new CONFIG_* symbols
for rwsem.

Later,
David S. Miller
davem@redhat.com
