Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317589AbSGXWTj>; Wed, 24 Jul 2002 18:19:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317593AbSGXWTj>; Wed, 24 Jul 2002 18:19:39 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:30707 "EHLO
	hermes.mvista.com") by vger.kernel.org with ESMTP
	id <S317589AbSGXWTi>; Wed, 24 Jul 2002 18:19:38 -0400
Subject: Re: Linux-2.5.28
From: Robert Love <rml@tech9.net>
To: William Lee Irwin III <wli@holomorphy.com>
Cc: Paul Larson <plars@austin.ibm.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20020724221423.GD25038@holomorphy.com>
References: <Pine.LNX.4.33.0207241410040.3542-100000@penguin.transmeta.com>
	<1027547187.7700.67.camel@plars.austin.ibm.com>
	<1027547856.7700.70.camel@plars.austin.ibm.com> 
	<20020724221423.GD25038@holomorphy.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 
Date: 24 Jul 2002 15:22:49 -0700
Message-Id: <1027549369.931.1354.camel@sinai>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2002-07-24 at 15:14, William Lee Irwin III wrote:
> On Wed, 2002-07-24 at 16:46, Paul Larson wrote:
> >> Error building 2.5.28:
> 
> On Wed, Jul 24, 2002 at 04:57:35PM -0500, Paul Larson wrote:
> > Forgot to mention this is an SMP box.  Without CONFIG_SMP it works fine.
> > -Paul Larson
> 
> Which drivers?

He reported the cmd640 driver... but we really do not need 100 "it does
not compile reports" on lkml.  Just grep your tree for the old global
IRQ methods... also, Ingo wrote a nice document in Documentation/ ..

	Robert Love

