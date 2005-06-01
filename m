Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261151AbVFATxZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261151AbVFATxZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Jun 2005 15:53:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261185AbVFATtc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Jun 2005 15:49:32 -0400
Received: from zodiac.mimuw.edu.pl ([193.0.96.128]:50061 "EHLO
	students.mimuw.edu.pl") by vger.kernel.org with ESMTP
	id S261183AbVFATtH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Jun 2005 15:49:07 -0400
Date: Wed, 1 Jun 2005 21:47:58 +0200
From: Marcin Bis <marcin.bis@students.mimuw.edu.pl>
To: linux-kernel@vger.kernel.org
Subject: Re: problem with ALSA ane intel modem driver
Message-ID: <20050601214758.037f989a@laptop>
In-Reply-To: <20050601161745.GB29436@sashak.softier.local>
References: <200505280716.46688.cijoml@volny.cz>
	<20050528154736.3ab2550a@laptop>
	<s5h64x0x2pc.wl@alsa2.suse.de>
	<20050531233712.7b782c6c@laptop>
	<20050601161745.GB29436@sashak.softier.local>
X-Mailer: Sylpheed-Claws 1.9.6cvs1 (GTK+ 2.6.4; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 01 Jun 2005 19:17:45 +0300
Sasha Khapyorsky <sashak@smlink.com> wrote:

> > Semaphore warning is fixed in ALSA CVS (but i still get NO DIALTONE/
> > NO CARRIER error for this modem).
> 
> It is likely not a driver problem, but modem sw (slmodem I guess) -
> the device dma should work for 'NO DIALTONE'.
> For sure drop please output of
> 'cat /proc/asound/card1/codec97#0/mc97#1-1' .

1-1/0: Silicon Laboratory Si3036/8 rev 1

Extended modem ID: codec=1 LIN1
Modem status     : GPIO ADC1 DAC1 PRB(res) PRE(ADC2) PRF(DAC2) PRG
(HADC) PRH(HDAC) Line1 rate       : 12000Hz

-- 
 Marcin Bis
