Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263930AbTDWBRE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Apr 2003 21:17:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263929AbTDWBRE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Apr 2003 21:17:04 -0400
Received: from stroke.of.genius.brain.org ([206.80.113.1]:39098 "EHLO
	stroke.of.genius.brain.org") by vger.kernel.org with ESMTP
	id S263926AbTDWBRD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Apr 2003 21:17:03 -0400
Date: Tue, 22 Apr 2003 21:29:03 -0400
From: "Murray J. Root" <murrayr@brain.org>
To: LKML <linux-kernel@vger.kernel.org>
Subject: Re: 2.5 kernel hangs system
Message-ID: <20030423012903.GI1249@Master.Bellsouth.net>
Mail-Followup-To: LKML <linux-kernel@vger.kernel.org>
References: <000501c3090c$71683c60$0200a8c0@satellite> <Pine.LNX.4.53.0304221649050.17809@chaos> <1051053106.710.4.camel@teapot.felipe-alfaro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1051053106.710.4.camel@teapot.felipe-alfaro.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 23, 2003 at 01:11:46AM +0200, Felipe Alfaro Solana wrote:
> On Tue, 2003-04-22 at 23:00, Richard B. Johnson wrote:
> > First, I don't understand how as you say, "suggestions are
> > desperately needed" on a developmental kernel. These things are
> > not known to work on all configurations and some information like
> > "It gives me hex codes..." is worthless. Please write down
> > these "hex-codes" and, after booting a version the works, run them
> > through ksymoops. If you don't know what that is:
> 
> ksymoops? I thought 2.5 kernels didn't need ksymoops anymore and that
> function names were automatically "guessed" in call stack traces.
> 

IFF you use "include symbols" when building you shouldn't need ksymoops.
IMO, if you're using 2.5.x you really should include the symbols - chances
are you'll need em.

-- 
Murray J. Root

