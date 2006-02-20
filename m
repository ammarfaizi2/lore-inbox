Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932466AbWBTAFl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932466AbWBTAFl (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Feb 2006 19:05:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932467AbWBTAFl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Feb 2006 19:05:41 -0500
Received: from viper.oldcity.dca.net ([216.158.38.4]:29382 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S932466AbWBTAFl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Feb 2006 19:05:41 -0500
Subject: Re: No sound from SB live!
From: Lee Revell <rlrevell@joe-job.com>
To: Alistair John Strachan <s0348365@sms.ed.ac.uk>
Cc: Pavel Machek <pavel@suse.cz>, Nishanth Aravamudan <nacc@us.ibm.com>,
       Nick Warne <nick@linicks.net>, Jesper Juhl <jesper.juhl@gmail.com>,
       tiwai@suse.de, ghrt@dial.kappa.ro, perex@suse.cz,
       kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <200602192356.39834.s0348365@sms.ed.ac.uk>
References: <20060218231419.GA3219@elf.ucw.cz>
	 <200602192323.08169.s0348365@sms.ed.ac.uk>
	 <1140391929.2733.430.camel@mindpipe>
	 <200602192356.39834.s0348365@sms.ed.ac.uk>
Content-Type: text/plain
Date: Sun, 19 Feb 2006 19:05:28 -0500
Message-Id: <1140393928.2733.441.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.5.91 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2006-02-19 at 23:56 +0000, Alistair John Strachan wrote:
> Thanks for this info Lee, and understand I don't hold anybody
> specifically in 
> the alsa team responsible but *deep breath*:
> 
> Please let everybody know about incompatible changes to alsa-lib know
> about it 
> prior to making the change mandatory. 

I thought it was already common knowledge that alsa-lib should be
upgraded when upgrading the kernel.

Each ALSA driver has both a userspace and a kernel component so alsa-lib
has to be upgraded to get new drivers anyway.

Lee

