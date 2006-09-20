Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932086AbWITRfZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932086AbWITRfZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Sep 2006 13:35:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932133AbWITRfZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Sep 2006 13:35:25 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:63452 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S932086AbWITRfY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Sep 2006 13:35:24 -0400
Date: Wed, 20 Sep 2006 10:35:12 -0700 (PDT)
From: Christoph Lameter <clameter@sgi.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Rohit Seth <rohitseth@google.com>,
       CKRM-Tech <ckrm-tech@lists.sourceforge.net>, devel@openvz.org,
       pj@sgi.com, npiggin@suse.de,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [patch00/05]: Containers(V2)- Introduction
In-Reply-To: <1158774491.7705.32.camel@localhost.localdomain>
Message-ID: <Pine.LNX.4.64.0609201034390.31464@schroedinger.engr.sgi.com>
References: <1158718568.29000.44.camel@galaxy.corp.google.com> 
 <Pine.LNX.4.64.0609200916140.30572@schroedinger.engr.sgi.com> 
 <1158773699.7705.19.camel@localhost.localdomain> 
 <Pine.LNX.4.64.0609201012310.30793@schroedinger.engr.sgi.com>
 <1158774491.7705.32.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 20 Sep 2006, Alan Cox wrote:

> If it can do it in a human understandable way, configured at runtime
> with dynamic sharing, overcommit and reconfiguration of sizes then
> great. Lets see what Paul has to say.

You have full VM support this means overcommit and every else you are used 
ot.

