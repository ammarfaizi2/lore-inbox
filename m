Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751651AbWCMRC3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751651AbWCMRC3 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Mar 2006 12:02:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751673AbWCMRC2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Mar 2006 12:02:28 -0500
Received: from viper.oldcity.dca.net ([216.158.38.4]:37557 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S1751634AbWCMRC2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Mar 2006 12:02:28 -0500
Subject: Re: Patch: MSI-K8T-Neo2-Fir OnboardSound and additional Soundcard
From: Lee Revell <rlrevell@joe-job.com>
To: Johannes Goecke <goecke@upb.de>
Cc: Linux-Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20060313075741.GA31459@uni-paderborn.de>
References: <20060311192840.GA19313@uni-paderborn.de>
	 <1142134890.25358.43.camel@mindpipe>
	 <20060313075741.GA31459@uni-paderborn.de>
Content-Type: text/plain
Date: Mon, 13 Mar 2006 12:02:21 -0500
Message-Id: <1142269342.25358.308.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.5.92 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-03-13 at 08:57 +0100, Johannes Goecke wrote:
> can someone give me a (kernel-programming-beginner-level) hint, for
> the first 
> question how to ensure to only execute if running on the right
> Mother-board?
> Af far as I believe the quirk so-far only checks the cipset, so it
> might
> behave wrong on other Mainborads!  

I believe a proper fix was already posted for this, the thread was
called:

[PATCH 001/001] PCI: PCI quirk for Asus A8V and A8V Deluxe motherboards

Simply add your board to the IDs.

Lee

