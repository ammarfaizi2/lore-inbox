Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264438AbTK2XOT (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 Nov 2003 18:14:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264490AbTK2XOT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 Nov 2003 18:14:19 -0500
Received: from intra.cyclades.com ([64.186.161.6]:17624 "EHLO
	intra.cyclades.com") by vger.kernel.org with ESMTP id S264438AbTK2XOF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 Nov 2003 18:14:05 -0500
Date: Sat, 29 Nov 2003 21:10:44 -0200 (BRST)
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
X-X-Sender: marcelo@logos.cnet
To: Samuel Flory <sflory@rackable.com>
Cc: Marcelo Tosatti <marcelo@hera.kernel.org>, <linux-kernel@vger.kernel.org>,
       <jgarzik@pobox.com>
Subject: Re: libata in 2.4.24?
In-Reply-To: <3FC91D22.8030404@rackable.com>
Message-ID: <Pine.LNX.4.44.0311292109340.1524-100000@logos.cnet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 29 Nov 2003, Samuel Flory wrote:

>    Are you considering including libata support for 2.4.24?  From my 
> testing with a number of different embedded sata chipsets (mostly ICH, 
> SI, and Promise) it appears very stable.  I'm not seeing any data 
> corruption or lockups when running Cerberus with 2.4.23-rc5 + libata 
> patch.  The only troubles I've had were with initialization of embedded 
> promise sata controllers. (I still need to test with Jeff's latest fixes 
> for this.)

I'm happy to include it in 2.4 when Jeff thinks its stable enough for a 
stable series. ;)


