Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264649AbUDVTwH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264649AbUDVTwH (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Apr 2004 15:52:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264643AbUDVTuh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Apr 2004 15:50:37 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:4815 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S264650AbUDVTuL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Apr 2004 15:50:11 -0400
Date: Tue, 20 Apr 2004 21:34:49 +0200
From: Pavel Machek <pavel@ucw.cz>
To: "Michal Semler (volny.cz)" <cijoml@volny.cz>
Cc: linux-kernel@vger.kernel.org
Subject: Re: standart events for hotkeys?
Message-ID: <20040420193449.GE1413@openzaurus.ucw.cz>
References: <200404200042.24671.cijoml@volny.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200404200042.24671.cijoml@volny.cz>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> I have a question related to keyboard and hotkeys.
> 
> Does any standart exist for hotkeys and their returned events?
> I have 2 keyboards with hotkeys, one on laptop (acerhk operated) and one 
> wireless (BlueZ bthid operated) and both returns different codes in xev when 
> same keys are pressed
> 
> mail
> browser
> etc.

I believe vojtech already has codes assigned to keys like those.
				Pavel
-- 
64 bytes from 195.113.31.123: icmp_seq=28 ttl=51 time=448769.1 ms         

