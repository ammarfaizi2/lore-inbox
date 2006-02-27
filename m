Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751196AbWB0WPG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751196AbWB0WPG (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Feb 2006 17:15:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751348AbWB0WPG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Feb 2006 17:15:06 -0500
Received: from omx1-ext.sgi.com ([192.48.179.11]:53405 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S1751196AbWB0WPF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Feb 2006 17:15:05 -0500
Date: Mon, 27 Feb 2006 14:14:52 -0800 (PST)
From: Christoph Lameter <clameter@engr.sgi.com>
To: Andi Kleen <ak@suse.de>
cc: Paul Jackson <pj@sgi.com>, dgc@sgi.com, steiner@sgi.com,
       Simon.Derr@bull.net, linux-kernel@vger.kernel.org, clameter@sgi.com
Subject: Re: [PATCH 01/02] cpuset memory spread slab cache filesys
In-Reply-To: <200602272202.34346.ak@suse.de>
Message-ID: <Pine.LNX.4.64.0602271414290.12093@schroedinger.engr.sgi.com>
References: <20060227070209.1994.26823.sendpatchset@jackhammer.engr.sgi.com>
 <200602272149.51257.ak@suse.de> <Pine.LNX.4.64.0602271253030.8274@schroedinger.engr.sgi.com>
 <200602272202.34346.ak@suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 27 Feb 2006, Andi Kleen wrote:

> On Monday 27 February 2006 21:56, Christoph Lameter wrote:
> > We could make the memory policy only apply if the SLAB_MEM_SPREAD option 
> Which memory policy? The one of the process?

Yes.
