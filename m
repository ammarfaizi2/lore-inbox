Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262710AbUBZHSR (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Feb 2004 02:18:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262709AbUBZHSR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Feb 2004 02:18:17 -0500
Received: from alt.aurema.com ([203.217.18.57]:48779 "EHLO smtp.sw.oz.au")
	by vger.kernel.org with ESMTP id S262710AbUBZHSQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Feb 2004 02:18:16 -0500
Date: Thu, 26 Feb 2004 18:18:13 +1100 (EST)
From: John Lee <johnl@aurema.com>
X-X-Sender: johnl@johnl.sw.oz.au
To: linux-kernel@vger.kernel.org
Subject: Re: [RFC][PATCH] O(1) Entitlement Based Scheduler
In-Reply-To: <Pine.GSO.4.03.10402260130140.2680-100000@swag.sw.oz.au>
Message-ID: <Pine.LNX.4.44.0402261812290.28427-100000@johnl.sw.oz.au>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 26 Feb 2004, John Lee wrote:

> The patch can be downloaded from
> 
> <http://sourceforge.net/projects/ebs-linux/>
> 
> Please note that there are 2 patches: the basic patch and the full patch. The
> above description applies to the full patch. The basic patch only features
> setting shares via nice, a fixed half life and timeslice, no statistics and 
> soft caps only. This basic patch is for those who are mainly interested in 
> looking at the core EBS changes to the stock scheduler.
> 
> The patches are against 2.6.2 (2.6.3 patches will be available shortly).

2.6.3 patches are now available.

John


