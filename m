Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262496AbUJ0P5X@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262496AbUJ0P5X (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Oct 2004 11:57:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262495AbUJ0P5W
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Oct 2004 11:57:22 -0400
Received: from viper.oldcity.dca.net ([216.158.38.4]:32661 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S262468AbUJ0P42 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Oct 2004 11:56:28 -0400
Subject: Re: [PATCH] Add p4-clockmod driver in x86-64
From: Lee Revell <rlrevell@joe-job.com>
To: Paulo Marques <pmarques@grupopie.com>
Cc: "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>,
       Andi Kleen <ak@suse.de>, akpm@osdl.org, linux-kernel@vger.kernel.org
In-Reply-To: <417FB7BA.9050005@grupopie.com>
References: <88056F38E9E48644A0F562A38C64FB600333A69D@scsmsx403.amr.corp.intel.com>
	 <417FB7BA.9050005@grupopie.com>
Content-Type: text/plain
Date: Wed, 27 Oct 2004 11:56:27 -0400
Message-Id: <1098892587.8313.5.camel@krustophenia.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-10-27 at 15:59 +0100, Paulo Marques wrote:
> I am one of the members of the robotic soccer team from the University 
> of Oporto, and a couple of months ago we were looking for new 
> motherboards for our robots, because we are starting to need new 
> hardware (on-board lan, usb2.0, etc.).
> 
> We really don't need excepcional performance, but we really, really need 
> low power consumption, so lowering the clock on a standard mainboard 
> seemed to be the best cost/performance scenario.
> 
> Could this driver be used to keep a standard p4 processor at say 25% 
> clock speed at all times?
> 

Why don't you try the VIA EPIA mini-ITX boards?  These are designed for
low power applications like yours.  I am running the M-6000 which has a
fanless 600Mhz C3 processor, the newer fanless models run at 1Ghz.  And,
on top of that they support speed scaling so you can slow it down even
more.

Lee 

