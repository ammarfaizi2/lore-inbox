Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263299AbTDCGqy>; Thu, 3 Apr 2003 01:46:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263300AbTDCGqy>; Thu, 3 Apr 2003 01:46:54 -0500
Received: from mail023.syd.optusnet.com.au ([210.49.20.162]:38071 "EHLO
	mail023.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id <S263299AbTDCGqx>; Thu, 3 Apr 2003 01:46:53 -0500
Message-ID: <18037.130.194.13.164.1049353252.squirrel@127.0.0.1>
Date: Thu, 3 Apr 2003 17:00:52 +1000 (EST)
Subject: Re: Synaptics Touchpad loses sync 2.5.66
From: "Stewart Smith" <stewartsmith@mac.com>
To: <brad@seme.com.au>
In-Reply-To: <3E8BCB4F.5080900@seme.com.au>
References: <3E8BCB4F.5080900@seme.com.au>
X-Priority: 3
Importance: Normal
X-MSMail-Priority: Normal
Cc: <linux-kernel@vger.kernel.org>
X-Mailer: SquirrelMail (version 1.2.6)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Brad Campbell said:
> G'day all,
> This is the show stopper for me using 2.5.x
> I have seen this since the first 2.5.x kernel I tried which was around
> 2.5.42.
> Under X 4.2.0 (Happened under 4.1.x also) the Touchpad loses sync quite
>  frequently causing the mouse to go haywire, jumping all over the
> screen  and sending button presses that I have not made.
> The exact same configuration works perfectly under 2.4.x

I would argue that their is something marjorly funny with the synaptics
touchpads themselves (in some scenareos at least). I have seen this
*exact* behaviour not only on linux (2.4, mandrake) but in Win98 and
Win2k. This was a Dell Inspiron 4000 which my gf of the time had. She's
had the warranty guys out several times to try and fix it, and atm it's
not happenning. I do remember something about the Dell guy saying it's a
known problem though...
There were also some strange things I had to do due to the way the machine
dealt with internal&external mice...
Just keep in mind it could be hardware related too. Yes, unpredictable and
all that, but I've seen the same thing on windows, which has been fixed
(albeit temporarily) by replacing the touchpad.
I haven't had time to try and code up a hack to fix it, sorry.
--------
Stewart Smith
stewartsmith@mac.com
ICQ: 6734154
Ph: +61 4 3884 4332


