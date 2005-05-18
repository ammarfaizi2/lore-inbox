Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262322AbVERSbL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262322AbVERSbL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 May 2005 14:31:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262285AbVERS3O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 May 2005 14:29:14 -0400
Received: from viper.oldcity.dca.net ([216.158.38.4]:59789 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S262313AbVERSZJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 May 2005 14:25:09 -0400
Subject: Re: software mixing in alsa
From: Lee Revell <rlrevell@joe-job.com>
To: Pierre Ossman <drzeus-list@drzeus.cx>
Cc: Takashi Iwai <tiwai@suse.de>, Valdis.Kletnieks@vt.edu,
       Karel Kulhavy <clock@twibright.com>, linux-kernel@vger.kernel.org
In-Reply-To: <428B5349.5090207@drzeus.cx>
References: <20050517095613.GA9947@kestrel>
	 <200505171208.04052.jan@spitalnik.net>	<20050517141307.GA7759@kestrel>
	 <1116354762.31830.12.camel@mindpipe>
	 <20050517192412.GA19431@kestrel.twibright.com>
	 <200505172027.j4HKRjTV029545@turing-police.cc.vt.edu>
	 <s5hll6csl0b.wl@alsa2.suse.de>  <428B5349.5090207@drzeus.cx>
Content-Type: text/plain
Date: Wed, 18 May 2005 14:25:04 -0400
Message-Id: <1116440704.4866.3.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.3.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-05-18 at 16:38 +0200, Pierre Ossman wrote:
> Takashi Iwai wrote:
> > 
> > esd is working fine together with dmix.  You should try the latest
> > versions (of esd and alsa-lib).  The old version of esd might have a
> > bug.
> > 
> 
> I'd beg to differ. I have to apply the patch made by you to avoid
> getting a lot of distortions with esound and dmix:
> 
> http://bugzilla.gnome.org/show_bug.cgi?id=140803
> 
> Checking in the cvs, this still hasn't been commited.

You really need to bug the Gnome developers about it.  Takashi-san
posted the patch in January, and the bug is still listed as NEW.

Lee

