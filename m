Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266013AbUH1B2p@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266013AbUH1B2p (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Aug 2004 21:28:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266096AbUH1B2p
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Aug 2004 21:28:45 -0400
Received: from 18-165-237-24-mvl.nwc.gci.net ([24.237.165.18]:62608 "EHLO
	nevaeh-linux.org") by vger.kernel.org with ESMTP id S266013AbUH1B2m
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Aug 2004 21:28:42 -0400
Date: Fri, 27 Aug 2004 17:27:19 -0800 (AKDT)
From: Arthur Corliss <corliss@digitalmages.com>
X-X-Sender: acorliss@bifrost.nevaeh-linux.org
To: Jay Lan <jlan@engr.sgi.com>
cc: Tim Schmielau <tim@physik3.uni-rostock.de>,
       Arthur Corliss <corliss@digitalmages.com>,
       Andrew Morton <akpm@osdl.org>, lkml <linux-kernel@vger.kernel.org>,
       erikj@dbear.engr.sgi.com, limin@engr.sgi.com,
       lse-tech@lists.sourceforge.net,
       =?windows-1252?Q?=3F?= <kernel@ragnark.vestdata.no>,
       Yoshitaka ISHIKAWA <y.ishikawa@soft.fujitsu.com>,
       Guillaume Thouvenin <guillaume.thouvenin@bull.net>
Subject: Re: [PATCH] new CSA patchset for 2.6.8
In-Reply-To: <412E4C27.1010805@engr.sgi.com>
Message-ID: <Pine.LNX.4.58.0408271727020.1075@bifrost.nevaeh-linux.org>
References: <412D2E10.8010406@engr.sgi.com> <20040825221842.72dd83a4.akpm@osdl.org>
 <Pine.LNX.4.53.0408261821090.14826@gockel.physik3.uni-rostock.de>
 <Pine.LNX.4.58.0408261111520.22750@bifrost.nevaeh-linux.org>
 <Pine.LNX.4.53.0408262133190.8515@broiler.physik3.uni-rostock.de>
 <412E4C27.1010805@engr.sgi.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Score: -1.971 () AWL,BAYES_00
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 26 Aug 2004, Jay Lan wrote:

> I do like to see a common data collection method in the kernl. Kernel
> does not need to decide how the data to be presented to the
> user space. An accounting loadable module such as CSA or ELSA will
> take care of how the data to be presented to meet the needs of
> different users.
>
> Sounds reasonable?

Seconded.

	--Arthur Corliss
	  Bolverk's Lair -- http://arthur.corlissfamily.org/
	  Digital Mages -- http://www.digitalmages.com/
	  "Live Free or Die, the Only Way to Live" -- NH State Motto
