Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263858AbTE0PZI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 May 2003 11:25:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263865AbTE0PZI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 May 2003 11:25:08 -0400
Received: from zork.zork.net ([64.81.246.102]:27880 "EHLO zork.zork.net")
	by vger.kernel.org with ESMTP id S263858AbTE0PZH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 May 2003 11:25:07 -0400
To: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.5.70 compile error
References: <Pine.LNX.4.44.0305261903330.2164-100000@home.transmeta.com>
	<200305271048.36495.devilkin-lkml@blindguardian.org>
	<20030527130515.GH8978@holomorphy.com>
	<200305271729.49047.devilkin-lkml@blindguardian.org>
From: Sean Neakums <sneakums@zork.net>
X-Worst-Pick-Up-Line-Ever: "Hey baby, wanna peer with my leafnode instance?"
X-Mooix: You can't do that.
X-Message-Flag: Message text advisory: HYPERLINK PATENT INFRINGEMENT, GRAVE
 ILL-JUDGEMENT
X-Mailer: Norman
X-Groin-Mounted-Steering-Wheel: "Arrrr... it's driving me nuts!"
X-Gilmore-Girls: http://www.achewood.com/index.php?date=04162003
X-Alameda: WHY DOESN'T ANYONE KNOW ABOUT ALAMEDA?  IT'S RIGHT NEXT TO
 OAKLAND!!!
Organization: The Emadonics Institute
Mail-Followup-To: linux-kernel@vger.kernel.org
Date: Tue, 27 May 2003 16:38:20 +0100
In-Reply-To: <200305271729.49047.devilkin-lkml@blindguardian.org> (devilkin-lkml@blindguardian.org's
 message of "Tue, 27 May 2003 17:29:48 +0200")
Message-ID: <6ullwso0wj.fsf@zork.zork.net>
User-Agent: Gnus/5.1003 (Gnus v5.10.3) Emacs/21.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

DevilKin-LKML <devilkin-lkml@blindguardian.org> writes:

> On Tuesday 27 May 2003 15:05, William Lee Irwin III wrote:
>> I suspect you're attempting to shoot yourself in the foot. .config?
>
> Ah, quite. I saw NUMA was activated, and disabling it fixed my
> problem. Odd though, that it should become active just by doing a
> 'make oldconfig' with my 2.7.69 config file...

I guess in the future, all boxes are NUMA.

-- 
Sean Neakums - <sneakums@zork.net>
