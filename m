Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291980AbSBAUeO>; Fri, 1 Feb 2002 15:34:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291982AbSBAUeE>; Fri, 1 Feb 2002 15:34:04 -0500
Received: from panic.ohr.gatech.edu ([130.207.47.194]:60070 "HELO gtf.org")
	by vger.kernel.org with SMTP id <S291980AbSBAUds>;
	Fri, 1 Feb 2002 15:33:48 -0500
Date: Fri, 1 Feb 2002 15:33:46 -0500
From: Jeff Garzik <garzik@havoc.gtf.org>
To: Peter Monta <pmonta@pmonta.com>
Cc: hpa@zytor.com, linux-kernel@vger.kernel.org
Subject: Re: Continuing /dev/random problems with 2.4
Message-ID: <20020201153346.B2497@havoc.gtf.org>
In-Reply-To: <20020201031744.A32127@asooo.flowerfire.com> <1012582401.813.1.camel@phantasy> <a3enf3$93p$1@cesium.transmeta.com> <20020201202334.72F921C5@www.pmonta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20020201202334.72F921C5@www.pmonta.com>; from pmonta@pmonta.com on Fri, Feb 01, 2002 at 12:23:34PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 01, 2002 at 12:23:34PM -0800, Peter Monta wrote:
> > Anything that is meant to be a server really pretty much needs an
> > enthropy generator these days.
> 
> Many motherboards have on-board sound.  Why not turn the mic
> gain all the way up and use the noise---surely there will be
> a few bits' worth?

Even if you think you have a good true source of random noise, you need
to run good fitness tests on the data to ensure it's truly random.

	Jeff



