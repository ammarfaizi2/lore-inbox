Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273524AbRIUNZV>; Fri, 21 Sep 2001 09:25:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273526AbRIUNZO>; Fri, 21 Sep 2001 09:25:14 -0400
Received: from colargol.tihlde.hist.no ([158.38.48.10]:9991 "HELO tihlde.org")
	by vger.kernel.org with SMTP id <S273524AbRIUNZE>;
	Fri, 21 Sep 2001 09:25:04 -0400
To: David Chow <davidchow@rcn.com.hk>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: Wrapfs a stackable file system
In-Reply-To: <3BAB0858.C22F5177@rcn.com.hk>
From: Oystein Viggen <oysteivi@tihlde.org>
Organization: Tihlde
X-MSMail-Priority: High
X-Spook: fissionable NORAD Ft. Bragg Bosnia plutonium Qaddafi Marxist 
X-URL: http://www.tihlde.org/~oysteivi/
Original-Sender: oysteivi@tihlde.org
X-Phone-Number: +47 97 11 48 58
X-Address: Tordenskioldsgt. 12, 7012 Trondheim, Norway
X-Face: R=b-K(^1#]KR?6moG:Wrc/t>p)?p`?bgHg36M3hZ>^?\akat3!nX*8xZpIvZrI#]ZzN`I<+
 L{8#pdH*1SOB$Zu-_e1<>iE$5cGiLhRem.ct.QtE=&v@9\S_6slX4='![%,F3^&ed5Y5g-#!N'Lr[s
 &Gfs3c}pYq^oUo{8l-qD87s[P1~+f([41~gD}Pj)nX|KcVv;tF4IIx%pnN\UL|SNT
Date: 21 Sep 2001 15:25:28 +0200
In-Reply-To: <3BAB0858.C22F5177@rcn.com.hk> (David Chow's message of "Fri, 21 Sep 2001 17:28:56 +0800")
Message-ID: <03vgicptfb.fsf@colargol.tihlde.org>
User-Agent: Gnus/5.090003 (Oort Gnus v0.03) XEmacs/21.1 (Capitol Reef)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* [	David Chow] 

> The idea is orinigally from FiST, a stackable file system. But the FiST
> owner Erez seems given up to maintain the project. At the time I receive
> the code, it is so buggy, even unusable, lots of segmentation fault
> problems. I have debugging the fs for quite a while. Now it is useful in
> just use as a file system wrapper. It is useful in chroot environments
> and hardlinks aren't available. It wraps a directory and mount to
> another directory on tops of any filesystems.

Is this not essentially what we already have with mount --bind in 2.4?

Oystein
-- 
When in doubt: Think again.
