Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315174AbSDWOZH>; Tue, 23 Apr 2002 10:25:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315215AbSDWOZG>; Tue, 23 Apr 2002 10:25:06 -0400
Received: from pizda.ninka.net ([216.101.162.242]:23269 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S315174AbSDWOZF>;
	Tue, 23 Apr 2002 10:25:05 -0400
Date: Tue, 23 Apr 2002 07:15:44 -0700 (PDT)
Message-Id: <20020423.071544.71966255.davem@redhat.com>
To: ak@suse.de
Cc: dj.barrow@asitatech.com, linux-kernel@vger.kernel.org
Subject: Re: novice coding in /linux/net/ipv4/util.c From: DJ Barrow
 <dj.barrow@asitatech.com>
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <p73it6j8xwl.fsf@oldwotan.suse.de>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Andi Kleen <ak@suse.de>
   Date: 22 Apr 2002 19:07:38 +0200
   
   Best would be probably to convert the few remaining users of in_ntoa
   to NIPQUAD and drop this function.

I'm doing this in my tree.
