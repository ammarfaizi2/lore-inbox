Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285907AbRLTDHW>; Wed, 19 Dec 2001 22:07:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285904AbRLTDHL>; Wed, 19 Dec 2001 22:07:11 -0500
Received: from pizda.ninka.net ([216.101.162.242]:9602 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S285907AbRLTDHF>;
	Wed, 19 Dec 2001 22:07:05 -0500
Date: Wed, 19 Dec 2001 19:06:29 -0800 (PST)
Message-Id: <20011219.190629.03111291.davem@redhat.com>
To: kerndev@sc-software.com
Cc: billh@tierra.ucsd.edu, bcrl@redhat.com, torvalds@transmeta.com,
        linux-kernel@vger.kernel.org, linux-aio@kvack.org
Subject: Re: aio
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <Pine.LNX.3.95.1011219184950.581H-100000@scsoftware.sc-software.com>
In-Reply-To: <20011219.184527.31638196.davem@redhat.com>
	<Pine.LNX.3.95.1011219184950.581H-100000@scsoftware.sc-software.com>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: John Heil <kerndev@sc-software.com>
   Date: Wed, 19 Dec 2001 18:57:34 +0000 (   )
   
   True for now, but if we want to expand linux into the enterprise and the
   desktop to a greater degree, then we need to support the Java community to
   draw them and their management in, rather than delaying beneficial 
   features until their number on lkml reaches critical mass for a design
   discussion.

Firstly, you say this as if server java applets do not function at all
or with acceptable performance today.  That is not true for the vast
majority of cases.

If java server applet performance in all cases is dependent upon AIO
(it is not), that would be pretty sad.  But it wouldn't be the first
time I've heard crap like that.  There is propaganda out there telling
people that 64-bit address spaces are needed for good java
performance.  Guess where that came from?  (hint: they invented java
and are in the buisness of selling 64-bit RISC processors)
