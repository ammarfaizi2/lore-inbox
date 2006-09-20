Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932347AbWITTxP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932347AbWITTxP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Sep 2006 15:53:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932343AbWITTxP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Sep 2006 15:53:15 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:8868 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S932324AbWITTxO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Sep 2006 15:53:14 -0400
Date: Wed, 20 Sep 2006 12:52:56 -0700 (PDT)
From: Christoph Lameter <clameter@sgi.com>
To: Chandra Seetharaman <sekharan@us.ibm.com>
cc: Rohit Seth <rohitseth@google.com>, npiggin@suse.de, pj@sgi.com,
       linux-kernel <linux-kernel@vger.kernel.org>, devel@openvz.org,
       CKRM-Tech <ckrm-tech@lists.sourceforge.net>
Subject: Re: [ckrm-tech] [patch00/05]: Containers(V2)- Introduction
In-Reply-To: <1158777240.6536.89.camel@linuxchandra>
Message-ID: <Pine.LNX.4.64.0609201252030.32409@schroedinger.engr.sgi.com>
References: <1158718568.29000.44.camel@galaxy.corp.google.com> 
 <Pine.LNX.4.64.0609200916140.30572@schroedinger.engr.sgi.com>
 <1158777240.6536.89.camel@linuxchandra>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 20 Sep 2006, Chandra Seetharaman wrote:

> cpuset partitions resource and hence the resource that are assigned to a
> node is not available for other cpuset, which is not good for "resource
> management".

cpusets can have one node in multiple cpusets.

