Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264277AbTLAVgX (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Dec 2003 16:36:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264280AbTLAVgX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Dec 2003 16:36:23 -0500
Received: from tench.street-vision.com ([212.18.235.100]:4249 "EHLO
	tench.street-vision.com") by vger.kernel.org with ESMTP
	id S264277AbTLAVgW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Dec 2003 16:36:22 -0500
Subject: Re: libata in 2.4.24?
From: Justin Cormack <justin@street-vision.com>
To: Greg Stark <gsstark@mit.edu>
Cc: Samuel Flory <sflory@rackable.com>,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       Kernel mailing list <linux-kernel@vger.kernel.org>,
       Jeff Garzik <jgarzik@pobox.com>
In-Reply-To: <87fzg4ckej.fsf@stark.dyndns.tv>
References: <Pine.LNX.4.44.0312010836130.13692-100000@logos.cnet>
	<3FCB8312.3050703@rackable.com>  <87fzg4ckej.fsf@stark.dyndns.tv>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-11) 
Date: 01 Dec 2003 21:36:41 +0000
Message-Id: <1070314602.11433.10.camel@lotte.street-vision.com>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2003-12-01 at 21:12, Greg Stark wrote:
> 
> Samuel Flory <sflory@rackable.com> writes:
> 
> >    It's getting harder to find a newly released motherboard without onboard
> > sata.  Not having  libata support means that anyone running 2.4 unpatched will
> > be unable to use such systems.
> 
> My motherboard has a SATA controller and I'm using it in non-legacy mode with
> 2.4.23. What is this libata thing I'm supposed to be needing?

It depends which sata controller it is whether it works. SOme do some
dont...

Justin


