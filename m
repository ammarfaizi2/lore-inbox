Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135545AbRDYN63>; Wed, 25 Apr 2001 09:58:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135735AbRDYN6T>; Wed, 25 Apr 2001 09:58:19 -0400
Received: from colargol.tihlde.hist.no ([158.38.48.10]:47885 "HELO tihlde.org")
	by vger.kernel.org with SMTP id <S135545AbRDYN6E>;
	Wed, 25 Apr 2001 09:58:04 -0400
To: "Jeroen Geusebroek" <Jeroen.Geusebroek@intellit.nl>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: IDE Raid supported with the HPT370?
In-Reply-To: <NCBBJKHJIKHIFECNNOAMIECEEDAA.Jeroen.Geusebroek@intellit.nl>
From: Oystein Viggen <oysteivi@tihlde.org>
Organization: Tihlde
X-Spook: Mena Vickie Weaver Delta Force Monica Lewinsky FBI bomb DES 
X-URL: http://www.tihlde.org/~oysteivi/
X-Phone-Number: +47 97 11 48 58
X-Address: Tordenskioldsgt. 12, 7012 Trondheim, Norway
X-MSMail-Priority: High
X-Face: R=b-K(^1#]KR?6moG:Wrc/t>p)?p`?bgHg36M3hZ>^?\akat3!nX*8xZpIvZrI#]ZzN`I<+
 L{8#pdH*1SOB$Zu-_e1<>iE$5cGiLhRem.ct.QtE=&v@9\S_6slX4='![%,F3^&ed5Y5g-#!N'Lr[s
 &Gfs3c}pYq^oUo{8l-qD87s[P1~+f([41~gD}Pj)nX|KcVv;tF4IIx%pnN\UL|SNT
Date: 25 Apr 2001 15:58:02 +0200
In-Reply-To: <NCBBJKHJIKHIFECNNOAMIECEEDAA.Jeroen.Geusebroek@intellit.nl>
Message-ID: <03vgntytcl.fsf@colargol.tihlde.org>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.1 (Capitol Reef)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoth "Jeroen Geusebroek": 

> If not, will i be able to work without raid then? (maybe using
> software raid)

http://www.linux-ide.org/chipsets.html

Yours is listed under "supported, but not for RAID", which probably
means it works well when accessing individual disks, which again should
mean it would work well for linux software RAID or LVM.

Oystein
-- 
Ebg13 arire tbrf bhg bs fglyr..
