Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136484AbREDSfi>; Fri, 4 May 2001 14:35:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136482AbREDSf2>; Fri, 4 May 2001 14:35:28 -0400
Received: from colargol.tihlde.hist.no ([158.38.48.10]:20743 "HELO tihlde.org")
	by vger.kernel.org with SMTP id <S136480AbREDSfQ>;
	Fri, 4 May 2001 14:35:16 -0400
To: Keith Owens <kaos@ocs.com.au>
Cc: Nico Schottelius <nicos@pcsystems.de>, linux-kernel@vger.kernel.org
Subject: Re: added a new feature: disable pc speaker
In-Reply-To: <8340.988979784@ocs3.ocs-net>
From: Oystein Viggen <oysteivi@tihlde.org>
Organization: Tihlde
X-Spook: Honduras cryptographic North Korea quiche Croatian Waco, Texas assassination 
X-URL: http://www.tihlde.org/~oysteivi/
X-Phone-Number: +47 97 11 48 58
X-Address: Tordenskioldsgt. 12, 7012 Trondheim, Norway
X-MSMail-Priority: High
X-Face: R=b-K(^1#]KR?6moG:Wrc/t>p)?p`?bgHg36M3hZ>^?\akat3!nX*8xZpIvZrI#]ZzN`I<+
 L{8#pdH*1SOB$Zu-_e1<>iE$5cGiLhRem.ct.QtE=&v@9\S_6slX4='![%,F3^&ed5Y5g-#!N'Lr[s
 &Gfs3c}pYq^oUo{8l-qD87s[P1~+f([41~gD}Pj)nX|KcVv;tF4IIx%pnN\UL|SNT
Date: 04 May 2001 20:35:06 +0200
In-Reply-To: <8340.988979784@ocs3.ocs-net>
Message-ID: <03wv7xm085.fsf@colargol.tihlde.org>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.1 (Capitol Reef)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoth Keith Owens: 

> Userspace problem, userspace fix.
> 
>   setterm -blength 0 (text)
>   xset b 0 (X11)

Well, some buggy programs don't care about you turning off beeping in
X.  I think gnome-terminal or such has its own checkbox for turning
beeps on or off. 

I still agree that this is fixing userspace bugs in the kernel, and
probably not desirable, even if I think I'd disable the pc speaker if
the kernel actually asked me.  If nothing else, I figure it would make
my kernel 0.5k or so smaller  ;)

Oystein
-- 
When in doubt: Recompile.
