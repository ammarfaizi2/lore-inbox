Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932192AbWFUPfL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932192AbWFUPfL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jun 2006 11:35:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932193AbWFUPfL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jun 2006 11:35:11 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:10220 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S932192AbWFUPfJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jun 2006 11:35:09 -0400
Date: Wed, 21 Jun 2006 08:35:04 -0700 (PDT)
From: Christoph Lameter <clameter@sgi.com>
To: Andrew Morton <akpm@osdl.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.17-mm1
In-Reply-To: <20060621042830.a11e87ff.akpm@osdl.org>
Message-ID: <Pine.LNX.4.64.0606210834330.18664@schroedinger.engr.sgi.com>
References: <20060621034857.35cfe36f.akpm@osdl.org> <20060621042830.a11e87ff.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 21 Jun 2006, Andrew Morton wrote:

> On Wed, 21 Jun 2006 03:48:57 -0700
> Andrew Morton <akpm@osdl.org> wrote:
> 
> > - ia64 doesn't compile for me, due to git-klibc problems (a truly ancient
> >   toolchain might be implicated).
> 
> Actually I did do a full ia64 allmodconfig build on a recent distro.  So
> it's "broken on RHAS 2.1".

Builds fine on SLES9.

