Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261339AbTDOMkw (for <rfc822;willy@w.ods.org>); Tue, 15 Apr 2003 08:40:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261341AbTDOMkw 
	(for <rfc822;linux-kernel-outgoing>);
	Tue, 15 Apr 2003 08:40:52 -0400
Received: from zork.zork.net ([66.92.188.166]:52461 "EHLO zork.zork.net")
	by vger.kernel.org with ESMTP id S261339AbTDOMkv 
	(for <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Apr 2003 08:40:51 -0400
To: linux-kernel@vger.kernel.org
Subject: Re: BUGed to death
From: Sean Neakums <sneakums@zork.net>
X-Worst-Pick-Up-Line-Ever: "Hey baby, wanna peer with my leafnode instance?"
X-Message-Flag: Message text advisory: DENIAL OF THE ANTECEDENT, ARGUMENTUM
 AD BACULUM
X-Mailer: Norman
X-Groin-Mounted-Steering-Wheel: "Arrrr... it's driving me nuts!"
X-Alameda: WHY DOESN'T ANYONE KNOW ABOUT ALAMEDA?  IT'S RIGHT NEXT TO
 OAKLAND!!!
Organization: The Emadonics Institute
Mail-Followup-To: linux-kernel@vger.kernel.org
Date: Tue, 15 Apr 2003 13:52:41 +0100
In-Reply-To: <6uwuhw0vto.fsf@zork.zork.net> (Sean Neakums's message of "Tue,
 15 Apr 2003 13:49:39 +0100")
Message-ID: <6uu1cz2a92.fsf@zork.zork.net>
User-Agent: Gnus/5.090018 (Oort Gnus v0.18) Emacs/21.2 (gnu/linux)
References: <80690000.1050351598@flay>
	<200304151401.00704.baldrick@wanadoo.fr>
	<20030415123134.GM9776@suse.de> <6uwuhw0vto.fsf@zork.zork.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sean Neakums <sneakums@zork.net> writes:

> #define BUG_ON(x) x; do the trick.  With any luck the compiler will
> throw away most of the simple comparisons and whatnot.

s/;/ might/

-- 
Sean Neakums - <sneakums@zork.net>
