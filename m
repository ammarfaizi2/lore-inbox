Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313287AbSC1XQd>; Thu, 28 Mar 2002 18:16:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313291AbSC1XQX>; Thu, 28 Mar 2002 18:16:23 -0500
Received: from jagor.srce.hr ([161.53.2.130]:43517 "EHLO jagor.srce.hr")
	by vger.kernel.org with ESMTP id <S313287AbSC1XQE>;
	Thu, 28 Mar 2002 18:16:04 -0500
Message-Id: <200203282315.AAA02844@jagor.srce.hr>
Content-Type: text/plain; charset=US-ASCII
From: Danijel Schiavuzzi <dschiavu@public.srce.hr>
Organization: Dead Poets Society
To: <linux-kernel@vger.kernel.org>
Subject: Re: Screen corruption in 2.4.18
Date: Fri, 29 Mar 2002 01:14:47 +0100
X-Mailer: KMail [version 1.3.1]
In-Reply-To: <Pine.LNX.4.33.0203281443500.17304-100000@whisper.jaggnet.org>
Cc: Bill Hammock <xcp@whisper.jaggnet.org>
X-UIN: 39223454
X-Operating-System: GNU/Linux 2.4.17
X-Troll: no
X-URL: <http://danijels.cjb.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 28 March 2002 23:46, Bill Hammock wrote:
> I have this chipset with a built-in S3 Savage and am experiencing the
> problem.  Up till now I just removed the line from pci-pc.c, safe or
> unsafe it fixed the video garble.

One more with the problem...

> I have the Asus Terminator "bare bones" system.  The small cute all-in-one
> box.
>
>
> 00:00.0 Host bridge: VIA Technologies, Inc. VT8363/8365 [KT133/KM133] (rev
> 81) 00:01.0 

It's interesting that everyone who is experiencing these problems has the 
*revision 81* of the VT8365 chipset! This should be the key...

Danijel
