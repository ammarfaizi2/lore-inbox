Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264327AbTKUIa0 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Nov 2003 03:30:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264328AbTKUIa0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Nov 2003 03:30:26 -0500
Received: from 81-2-122-30.bradfords.org.uk ([81.2.122.30]:12160 "EHLO
	81-2-122-30.bradfords.org.uk") by vger.kernel.org with ESMTP
	id S264327AbTKUIaZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Nov 2003 03:30:25 -0500
Date: Fri, 21 Nov 2003 08:34:24 GMT
From: John Bradford <john@grabjohn.com>
Message-Id: <200311210834.hAL8YOKw000394@81-2-122-30.bradfords.org.uk>
To: Jamie Lokier <jamie@shareable.org>, "H. Peter Anvin" <hpa@zytor.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20031120232532.GA8229@mail.shareable.org>
References: <20031120020218.GJ3748@schottelius.org>
 <200311201210.04780.ben@jeeves.bpa.nu>
 <20031120083827.GL3748@schottelius.org>
 <bpitsu$732$1@cesium.transmeta.com>
 <20031120232532.GA8229@mail.shareable.org>
Subject: Re: transmeta cpu code question
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quote from Jamie Lokier <jamie@shareable.org>:
> H. Peter Anvin wrote:
> > It's also not faster in any meaningful way, since the dynamic
> > translator does optimistic optimization.
> 
> Statically compiled code for the Crusoe chips may not be faster.
> (Arguably statically compiled code for _any_ CPU is not the best
> strategy for fast code).
> 
> But if someone is able to write better code morphing software than
> Transmeta, that would be faster :)

The idea of a CMS which only implemented the subset of X86
instructions that gcc actually uses was discussed on the list a few
months ago, but unsuprisingly it never progressed beyond the thought
experiment stage.

John.
