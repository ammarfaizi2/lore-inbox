Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263479AbTLDUb6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Dec 2003 15:31:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263496AbTLDUb6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Dec 2003 15:31:58 -0500
Received: from cruftix.physics.uiowa.edu ([128.255.70.79]:49581 "EHLO cruftix")
	by vger.kernel.org with ESMTP id S263479AbTLDUb4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Dec 2003 15:31:56 -0500
Date: Thu, 4 Dec 2003 14:31:42 -0600
From: Joseph Pingenot <trelane@digitasaru.net>
To: Takashi Iwai <tiwai@suse.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: vanilla 2.6.0-test11 and CS4236 card
Message-ID: <20031204203140.GB13105@digitasaru.net>
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

Status update.

I removed the nvida driver module (thus making it, contrary to what I
  had considered vanilla) *truly* vanilla.  [Sorry about that; I really
  didn't mean to mislead.]
Upon reboot, the cs4236B "card" works 100% (although, for some reason, the
  xmms alsa drivers can't talk to it directly, but that's survivable;
  I'm using esd right now anyway; it's likely a debian problem or a
  Joe Confusigration problem).
My compliments and gratitude to all those who helped; I have now moved
  my workstation to 2.6.  I'll buy a student copy of SuSE when my laptop
  gets here next week.  ;)

-Joseph

-- 
trelane@digitasaru.net--------------------------------------------------
"We continue to live in a world where all our know-how is locked into
 binary files in an unknown format. If our documents are our corporate
 memory, Microsoft still has us all condemned to Alzheimer's."
    --Simon Phipps, http://theregister.com/content/4/30410.html
