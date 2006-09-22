Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964860AbWIVSXU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964860AbWIVSXU (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Sep 2006 14:23:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964861AbWIVSXU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Sep 2006 14:23:20 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:64190 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S964860AbWIVSXT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Sep 2006 14:23:19 -0400
Date: Fri, 22 Sep 2006 11:22:56 -0700 (PDT)
From: Christoph Lameter <clameter@sgi.com>
To: David Rientjes <rientjes@cs.washington.edu>
cc: Andrew Morton <akpm@osdl.org>,
       KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>, kmannth@us.ibm.com,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] do not free non slab allocated per_cpu_pageset
In-Reply-To: <Pine.LNX.4.64N.0609221117210.5858@attu2.cs.washington.edu>
Message-ID: <Pine.LNX.4.64.0609221122120.8326@schroedinger.engr.sgi.com>
References: <1158884252.5657.38.camel@keithlap> <20060921174134.4e0d30f2.akpm@osdl.org>
 <1158888843.5657.44.camel@keithlap> <20060922112427.d5f3aef6.kamezawa.hiroyu@jp.fujitsu.com>
 <20060921200806.523ce0b2.akpm@osdl.org> <20060922123045.d7258e13.kamezawa.hiroyu@jp.fujitsu.com>
 <20060921204629.49caa95f.akpm@osdl.org> <Pine.LNX.4.64N.0609212108360.30543@attu1.cs.washington.edu>
 <Pine.LNX.4.64N.0609221117210.5858@attu2.cs.washington.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 22 Sep 2006, David Rientjes wrote:

> Signed-off-by: David Rientjes <rientjes@cs.washington.edu>

Acked-by: Christoph Lameter <clameter@sgi.com>
