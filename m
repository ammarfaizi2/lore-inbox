Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290299AbSAPAjH>; Tue, 15 Jan 2002 19:39:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290300AbSAPAi7>; Tue, 15 Jan 2002 19:38:59 -0500
Received: from wire.cadcamlab.org ([156.26.20.181]:44551 "EHLO
	wire.cadcamlab.org") by vger.kernel.org with ESMTP
	id <S290299AbSAPAir>; Tue, 15 Jan 2002 19:38:47 -0500
Date: Tue, 15 Jan 2002 18:38:39 -0600
To: Russell King <rmk@arm.linux.org.uk>
Cc: linux-kernel@vger.kernel.org, kbuild-devel@lists.sourceforge.net
Subject: Re: CML2-2.1.3 is available
Message-ID: <20020116003839.GB2067@cadcamlab.org>
In-Reply-To: <20020115145324.A5772@thyrsus.com> <20020115202518.G1822@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020115202518.G1822@flint.arm.linux.org.uk>
User-Agent: Mutt/1.3.25i
From: Peter Samuelson <peter@cadcamlab.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


  [esr]
> > 	* The `vitality' flag is gone from the language.  Instead, the 
> > 	  autoprober detects the type of your root filesystem and forces
> > 	  its symbol to Y.

[Russell King]
> This seems like a backwards step.  What's the reasoning for breaking
> the ability to configure the kernel for a completely different
> machine to the one that you're running the configuration/build on?

As Eric keeps saying - autoconfigure is OPTIONAL.  It is merely one way
to generate a .config, not the only way.

> Answers including Aunt Tillies or Penelopes won't be accepted. 8)

(:

Peter
