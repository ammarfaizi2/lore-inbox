Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291972AbSBAUX4>; Fri, 1 Feb 2002 15:23:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291970AbSBAUXo>; Fri, 1 Feb 2002 15:23:44 -0500
Received: from adsl-63-197-0-76.dsl.snfc21.pacbell.net ([63.197.0.76]:15375
	"HELO www.pmonta.com") by vger.kernel.org with SMTP
	id <S291966AbSBAUXf>; Fri, 1 Feb 2002 15:23:35 -0500
From: Peter Monta <pmonta@pmonta.com>
To: hpa@zytor.com
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <a3enf3$93p$1@cesium.transmeta.com> (hpa@zytor.com)
Subject: Re: Continuing /dev/random problems with 2.4
In-Reply-To: <20020201031744.A32127@asooo.flowerfire.com> <1012582401.813.1.camel@phantasy> <a3enf3$93p$1@cesium.transmeta.com>
Message-Id: <20020201202334.72F921C5@www.pmonta.com>
Date: Fri,  1 Feb 2002 12:23:34 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Anything that is meant to be a server really pretty much needs an
> enthropy generator these days.

Many motherboards have on-board sound.  Why not turn the mic
gain all the way up and use the noise---surely there will be
a few bits' worth?

Perhaps there ought to be a way to give bits to the kernel's
/dev/random input hopper from user space.

Cheers,
Peter Monta
