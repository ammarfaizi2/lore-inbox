Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261191AbTCFXXr>; Thu, 6 Mar 2003 18:23:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261263AbTCFXXq>; Thu, 6 Mar 2003 18:23:46 -0500
Received: from adsl-157-194-9.dab.bellsouth.net ([66.157.194.9]:50361 "EHLO
	midgaard.us") by vger.kernel.org with ESMTP id <S261191AbTCFXXq>;
	Thu, 6 Mar 2003 18:23:46 -0500
Subject: Re: Kernel bloat 2.4 vs. 2.5
From: Andreas Boman <aboman@midgaard.us>
To: Daniel Egger <degger@fhm.edu>
Cc: Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>
In-Reply-To: <1046980273.18897.30.camel@sonja>
References: <20030306142252.22630.qmail@linuxmail.org>
	 <1046980273.18897.30.camel@sonja>
Content-Type: text/plain
Organization: 
Message-Id: <1046993653.30701.3.camel@asgaard.midgaard.us>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 
Date: 06 Mar 2003 18:34:13 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2003-03-06 at 14:51, Daniel Egger wrote:
> Am Don, 2003-03-06 um 15.22 schrieb Felipe Alfaro Solana:
> 
> > ??? I'm using 2.5 and modules do work perfectly... Did you 
> > get Rusty's latest modutils? 
> 
> Negative, I'm using what Debian (unstable in this case) provides
> me. This system has to be booted by a variety of systems, will the
> latest modutils work with 2.4 without modification?
> 
> This is what I have:
> ii  modutils       2.4.21-1       Linux module utilities.
>  

apt-get install module-init-tools, it will install 'right' and let you
use modules with 2.4 and 2.5 kernels.

--
Andreas

