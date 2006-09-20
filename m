Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932336AbWITTzi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932336AbWITTzi (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Sep 2006 15:55:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932343AbWITTzi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Sep 2006 15:55:38 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:18341 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S932336AbWITTzh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Sep 2006 15:55:37 -0400
Date: Wed, 20 Sep 2006 12:55:25 -0700 (PDT)
From: Christoph Lameter <clameter@sgi.com>
To: Chandra Seetharaman <sekharan@us.ibm.com>
cc: Paul Menage <menage@google.com>, npiggin@suse.de,
       CKRM-Tech <ckrm-tech@lists.sourceforge.net>,
       linux-kernel <linux-kernel@vger.kernel.org>, pj@sgi.com,
       Rohit Seth <rohitseth@google.com>, devel@openvz.org
Subject: Re: [ckrm-tech] [patch00/05]: Containers(V2)- Introduction
In-Reply-To: <1158778496.6536.95.camel@linuxchandra>
Message-ID: <Pine.LNX.4.64.0609201253440.32409@schroedinger.engr.sgi.com>
References: <1158718568.29000.44.camel@galaxy.corp.google.com> 
 <Pine.LNX.4.64.0609200916140.30572@schroedinger.engr.sgi.com> 
 <1158777240.6536.89.camel@linuxchandra>  <6599ad830609201143h19f6883wb388666e27913308@mail.google.com>
 <1158778496.6536.95.camel@linuxchandra>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 20 Sep 2006, Chandra Seetharaman wrote:

> We had this discussion more than 18 months back and concluded that it is
> not the right thing to do. Here is the link to the thread:

Recent discussions on linux-mm sounded very different. I also brought this 
up at the VM summit. Could you have a look at cpusets and the discussion 
on linux-mm and then think how this could be done in a less VM invasive 
way?


