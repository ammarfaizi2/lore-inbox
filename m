Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751366AbWHIUoA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751366AbWHIUoA (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Aug 2006 16:44:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751368AbWHIUoA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Aug 2006 16:44:00 -0400
Received: from viper.oldcity.dca.net ([216.158.38.4]:39339 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S1751366AbWHIUn7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Aug 2006 16:43:59 -0400
Subject: Re: alsa driver problem (snd_via82xx)
From: Lee Revell <rlrevell@joe-job.com>
To: Bartlomiej Celary <bartlomiej.celary@gmail.com>
Cc: linux-kernel@vger.kernel.org,
       alsa-devel <alsa-devel@lists.sourceforge.net>
In-Reply-To: <97c31bd80608091159h40db8bc2l891cab8ddf7165ef@mail.gmail.com>
References: <97c31bd80608091159h40db8bc2l891cab8ddf7165ef@mail.gmail.com>
Content-Type: text/plain
Date: Wed, 09 Aug 2006 16:43:55 -0400
Message-Id: <1155156235.26338.196.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-08-09 at 20:59 +0200, Bartlomiej Celary wrote:
> Hello,
> 
> I am having a problem with alsa driver. It is not a big issue, but a
> significant drawback...
> Ive used the form, so here it is.
> 
> [1.] One line summary of the problem:
> While using snd_via82xx the PCM volume is not responding to changing
> Master Volume.

This should be reported to the ALSA bug tracker (or alsa-devel mailing
list if you can help fix the code), not LKML:

https://bugtrack.alsa-project.org/alsa-bug/bug_report_advanced_page.php

Lee

