Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263335AbRFADXS>; Thu, 31 May 2001 23:23:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263338AbRFADXI>; Thu, 31 May 2001 23:23:08 -0400
Received: from pizda.ninka.net ([216.101.162.242]:49589 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S263335AbRFADXD>;
	Thu, 31 May 2001 23:23:03 -0400
From: "David S. Miller" <davem@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15127.2647.122105.362503@pizda.ninka.net>
Date: Thu, 31 May 2001 20:21:59 -0700 (PDT)
To: Tim Hockin <thockin@sun.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, alan@redhat.com
Subject: Re: [PATCH] save source address on accept()
In-Reply-To: <3B16EFE0.D0C44FB8@sun.com>
In-Reply-To: <3B16EFE0.D0C44FB8@sun.com>
X-Mailer: VM 6.75 under 21.1 (patch 13) "Crater Lake" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Tim Hockin writes:
 > attached is a (small) patch which saves the src address on tcp_accept(). 
 > Please let me know if there are any problems taking this for general
 > inclusion.

And what would this even be used for?  I see no need for it.

Later,
David S. Miller
davem@redhat.com
