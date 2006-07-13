Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030346AbWGMULL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030346AbWGMULL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jul 2006 16:11:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030344AbWGMULL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jul 2006 16:11:11 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:12717 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1030346AbWGMULK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jul 2006 16:11:10 -0400
Date: Thu, 13 Jul 2006 13:11:05 -0700 (PDT)
From: Christoph Lameter <clameter@sgi.com>
To: Hans Reiser <reiser@namesys.com>
cc: Reiserfs mail-list <Reiserfs-List@namesys.com>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: short term task list for Reiser4
In-Reply-To: <44B6A4A2.2070401@namesys.com>
Message-ID: <Pine.LNX.4.64.0607131310570.29555@schroedinger.engr.sgi.com>
References: <44B42064.4070802@namesys.com> <Pine.LNX.4.64.0607131215310.28976@schroedinger.engr.sgi.com>
 <44B6A4A2.2070401@namesys.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 13 Jul 2006, Hans Reiser wrote:

> Christoph Lameter wrote:
> 
> >Will there be any NUMA /SMP fixes? Reiserfs performance is severely 
> >impacted at higher processor counts by the mandatory centralized locking 
> >in both read and write paths in the filesystem.
> Reiserfs or Reiser4?

Either.
 
