Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750788AbWITXv4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750788AbWITXv4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Sep 2006 19:51:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750789AbWITXv4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Sep 2006 19:51:56 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:40598 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1750788AbWITXvz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Sep 2006 19:51:55 -0400
Date: Wed, 20 Sep 2006 16:51:45 -0700 (PDT)
From: Christoph Lameter <clameter@sgi.com>
To: Rohit Seth <rohitseth@google.com>
cc: Paul Jackson <pj@sgi.com>, ckrm-tech@lists.sourceforge.net,
       devel@openvz.org, npiggin@suse.de, linux-kernel@vger.kernel.org
Subject: Re: [patch00/05]: Containers(V2)- Introduction
In-Reply-To: <1158795569.7207.23.camel@galaxy.corp.google.com>
Message-ID: <Pine.LNX.4.64.0609201651001.2055@schroedinger.engr.sgi.com>
References: <1158718568.29000.44.camel@galaxy.corp.google.com> 
 <Pine.LNX.4.64.0609200916140.30572@schroedinger.engr.sgi.com> 
 <1158773208.8574.53.camel@galaxy.corp.google.com> 
 <Pine.LNX.4.64.0609201035240.31464@schroedinger.engr.sgi.com> 
 <1158775678.8574.81.camel@galaxy.corp.google.com>  <20060920155815.33b03991.pj@sgi.com>
  <Pine.LNX.4.64.0609201601450.1026@schroedinger.engr.sgi.com> 
 <1158795231.7207.21.camel@galaxy.corp.google.com> 
 <Pine.LNX.4.64.0609201634450.1955@schroedinger.engr.sgi.com>
 <1158795569.7207.23.camel@galaxy.corp.google.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 20 Sep 2006, Rohit Seth wrote:

> > Could we equip containers with restrictions on processors and nodes for 
> > NUMA?
> Yes.  That is something we will have to do (I think part of CPU
> handler-TBD).

Paul: Will we still need cpusets if that is there?

