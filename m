Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261737AbRESKIx>; Sat, 19 May 2001 06:08:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261741AbRESKIn>; Sat, 19 May 2001 06:08:43 -0400
Received: from hog.ctrl-c.liu.se ([130.236.252.129]:38160 "HELO
	hog.ctrl-c.liu.se") by vger.kernel.org with SMTP id <S261737AbRESKIZ>;
	Sat, 19 May 2001 06:08:25 -0400
To: linux-kernel@vger.kernel.org
Subject: Re: [RFD w/info-PATCH] device arguments from lookup, partion code in
 userspace
Newsgroups: linux.kernel
In-Reply-To: <20010519094224.AD5A236DDC@hog.ctrl-c.liu.se>
In-Reply-To: <Pine.LNX.4.33.0105190138150.6079-100000@toomuch.toronto.redhat.com>
Message-Id: <20010519095158.B403736DDC@hog.ctrl-c.liu.se>
Date: Sat, 19 May 2001 11:51:58 +0200 (CEST)
From: wingel@hog.ctrl-c.liu.se (Christer Weinigel)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <20010519094224.AD5A236DDC@hog.ctrl-c.liu.se> I wrote:
>The only problem I can see with this is that it removes one useful thing,
>the ability to give a user access to a whole partition.
>
>    chown wingel /dev/hda5
>
>won't work anymore since there is no such device node.  

Apologies, this should have gone to linux-fsdev, I entered the mail
address by hand and by reflex typed the wrong thing.  

*going back to sleep*

  /Christer

-- 
"Just how much can I get away with and still go to heaven?"
