Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932153AbWITRjK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932153AbWITRjK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Sep 2006 13:39:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932146AbWITRjJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Sep 2006 13:39:09 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:6124 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S932144AbWITRjG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Sep 2006 13:39:06 -0400
Date: Wed, 20 Sep 2006 10:38:57 -0700 (PDT)
From: Christoph Lameter <clameter@sgi.com>
To: Rohit Seth <rohitseth@google.com>
cc: Andrew Morton <akpm@osdl.org>, CKRM-Tech <ckrm-tech@lists.sourceforge.net>,
       devel@openvz.org, linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [patch01/05]:Containers(V2): Documentation
In-Reply-To: <1158773327.8574.55.camel@galaxy.corp.google.com>
Message-ID: <Pine.LNX.4.64.0609201038220.31464@schroedinger.engr.sgi.com>
References: <1158718655.29000.47.camel@galaxy.corp.google.com> 
 <Pine.LNX.4.64.0609200940550.30754@schroedinger.engr.sgi.com>
 <1158773327.8574.55.camel@galaxy.corp.google.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 20 Sep 2006, Rohit Seth wrote:

> Most of the syntax of cpuset is in terms of nodes and CPU numbers.  That
> is not the case here in containers.

Think about a container as a virtual node that can be configured to have a 
certain size.

