Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270797AbTHJXAy (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Aug 2003 19:00:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270801AbTHJXAx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Aug 2003 19:00:53 -0400
Received: from smtp3.libero.it ([193.70.192.127]:26063 "EHLO smtp3.libero.it")
	by vger.kernel.org with ESMTP id S270797AbTHJXAv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Aug 2003 19:00:51 -0400
Date: Mon, 11 Aug 2003 01:00:53 +0200
From: adri <adriano.archetti@tiscali.it>
To: Andries Brouwer <aebr@win.tue.nl>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.0-test1/2 won't let me use keyboard
Message-ID: <20030810230053.GA3868@inwind.it>
Mail-Followup-To: adri <adriano.archetti@tiscali.it>,
	Andries Brouwer <aebr@win.tue.nl>, linux-kernel@vger.kernel.org
References: <20030728214523.GA485@inwind.it> <20030729142025.GA2180@win.tue.nl> <20030730072708.GA893@inwind.it> <20030802223740.GA655@inwind.it> <20030804095310.GA4420@win.tue.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030804095310.GA4420@win.tue.nl>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

il giorno Mon, Aug 04, 2003 at 11:53:10AM +0200, Andries Brouwer ha scritto
> Yes, thanks for confirming. The new input code generates the repeat
> synthetically, by setting a timer, and that code must be buggy.
i apologies for the retard in my response but i have so much work in my
job...
i think the problem is in "rtc module not found": in that way it's
possible that the kernel wouldn't see the timer to stop my keyboard
repeat?
if so, please, let me know where i can find information to try to solve
the problem.
(i also apologies for my bad english!) ;))
thanks
adri
-- 
icq# 63011800 - jabber: adri@jabber.org
gnupg key id: 4472FB13
"Non esiste vento favorevole per il marinaio che non sa dove andare."
Seneca
