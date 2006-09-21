Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750726AbWIUAIL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750726AbWIUAIL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Sep 2006 20:08:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750764AbWIUAIK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Sep 2006 20:08:10 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:31947 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S1750726AbWIUAIJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Sep 2006 20:08:09 -0400
Date: Wed, 20 Sep 2006 17:07:59 -0700
From: Paul Jackson <pj@sgi.com>
To: "Paul Menage" <menage@google.com>
Cc: alan@lxorguk.ukuu.org.uk, clameter@sgi.com, npiggin@suse.de,
       ckrm-tech@lists.sourceforge.net, linux-kernel@vger.kernel.org,
       rohitseth@google.com, devel@openvz.org
Subject: Re: [ckrm-tech] [patch00/05]: Containers(V2)- Introduction
Message-Id: <20060920170759.c31c0596.pj@sgi.com>
In-Reply-To: <6599ad830609201653g4f44a4frb308eaeb63f83d2a@mail.google.com>
References: <1158718568.29000.44.camel@galaxy.corp.google.com>
	<Pine.LNX.4.64.0609200916140.30572@schroedinger.engr.sgi.com>
	<1158773699.7705.19.camel@localhost.localdomain>
	<6599ad830609201030w38b6ae59ia0d4a4ccabb47054@mail.google.com>
	<20060920163722.1442c5c1.pj@sgi.com>
	<6599ad830609201653g4f44a4frb308eaeb63f83d2a@mail.google.com>
Organization: SGI
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.3; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paul M wrote:
> An alternative would be a way of binding files (or directory
> hierarchies) to a particular set of memory nodes. Then you wouldn't
> need to pre-fault the data. Extended attributes might be one way of
> doing it.

Some of the file system folks have considered such use of extended
attributes, yes.

I remain unaware that any relation between that work and cpusets
exists or should exist.

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.925.600.0401
