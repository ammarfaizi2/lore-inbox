Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262729AbTLBRw1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Dec 2003 12:52:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262731AbTLBRw1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Dec 2003 12:52:27 -0500
Received: from cruftix.physics.uiowa.edu ([128.255.70.79]:8079 "EHLO cruftix")
	by vger.kernel.org with ESMTP id S262729AbTLBRw0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Dec 2003 12:52:26 -0500
Date: Tue, 2 Dec 2003 11:52:18 -0600
From: Joseph Pingenot <trelane@digitasaru.net>
To: Takashi Iwai <tiwai@suse.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: vanilla 2.6.0-test11 and CS4236 card
Message-ID: <20031202175216.GE5475@digitasaru.net>
Reply-To: trelane@digitasaru.net
Mail-Followup-To: Takashi Iwai <tiwai@suse.de>,
	linux-kernel@vger.kernel.org
References: <20031202170637.GD5475@digitasaru.net> <s5hsmk3ceia.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <s5hsmk3ceia.wl@alsa2.suse.de>
X-School: University of Iowa
X-vi-or-emacs: vi *and* emacs!
X-MSMail-Priority: High
X-Priority: 1 (Highest)
X-MS-TNEF-Correlator: <AFJAUFHRUOGRESULWAOIHFEAUIOFBVHSHNRAIU.monkey@spamcentral.invalid>
X-MimeOLE: Not Produced By Microsoft MimeOLE V5.50.4522.1200
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>From Takashi Iwai on Tuesday, 02 December, 2003:

Thanks.  I'm trying to track it down via diagnostic printk statements;
  right now, it's failing at least somewhere in snd_cs4231_lib
  (am at cs4231_probe atm; is failing right there atm).
I'll test the patch when I can.

-Joseph
-- 
trelane@digitasaru.net--------------------------------------------------
"We continue to live in a world where all our know-how is locked into
 binary files in an unknown format. If our documents are our corporate
 memory, Microsoft still has us all condemned to Alzheimer's."
    --Simon Phipps, http://theregister.com/content/4/30410.html
