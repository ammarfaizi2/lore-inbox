Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267256AbSK3OvS>; Sat, 30 Nov 2002 09:51:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267257AbSK3OvS>; Sat, 30 Nov 2002 09:51:18 -0500
Received: from zork.zork.net ([66.92.188.166]:23999 "EHLO zork.zork.net")
	by vger.kernel.org with ESMTP id <S267256AbSK3OvR>;
	Sat, 30 Nov 2002 09:51:17 -0500
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCHSET] Linux 2.4.20-jam0
References: <20021129233807.GA1610@werewolf.able.es>
	<3DE80AB6.611F3A8C@digeo.com> <20021130144541.GA2517@werewolf.able.es>
From: Sean Neakums <sneakums@zork.net>
X-Worst-Pick-Up-Line-Ever: "Hey baby, wanna peer with my leafnode instance?"
X-Message-Flag: Message text advisory: ARGUMENTUM AD BACULUM, DENIAL OF THE
 ANTECEDENT
X-Mailer: Norman
X-Groin-Mounted-Steering-Wheel: "Arrrr... it's driving me nuts!"
X-Alameda: : WHY DOESN'T ANYONE KNOW ABOUT ALAMEDA?  IT'S RIGHT NEXT TO
 OAKLAND!!!
Organization: The Emadonics Institute
Mail-Followup-To: linux-kernel@vger.kernel.org
Date: Sat, 30 Nov 2002 14:58:42 +0000
In-Reply-To: <20021130144541.GA2517@werewolf.able.es> ("J.A. Magallon"'s
 message of "Sat, 30 Nov 2002 15:45:41 +0100")
Message-ID: <6u3cpj3xzx.fsf@zork.zork.net>
User-Agent: Gnus/5.090008 (Oort Gnus v0.08) Emacs/21.2
 (i386-debian-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

commence  J.A. Magallon quotation:

> Thanks, I will add it...
> BTW, who puts names to options ? Wouldn't be more intuitive to add options
> like 'ialloc_std' or 'ialloc_orlov' ? Too late to change this ?

There isn't exactly a whole lot of contention in the mount-options
namespace.  And neither orlov not ialloc_orlov is in any way
"intuitive".  However, orlov is more guessable, to my mind, than
ialloc_orlov.

-- 
 /                          |
[|] Sean Neakums            |  Questions are a burden to others;
[|] <sneakums@zork.net>     |      answers a prison for oneself.
 \                          |
