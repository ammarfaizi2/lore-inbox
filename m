Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964855AbVHIQNl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964855AbVHIQNl (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Aug 2005 12:13:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964856AbVHIQNl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Aug 2005 12:13:41 -0400
Received: from clock-tower.bc.nu ([81.2.110.250]:54985 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S964855AbVHIQNk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Aug 2005 12:13:40 -0400
Subject: Re: [PATCH] Kernels Out Of Memoy(OOM) killer Problem ?
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Thomas Habets <thomas@habets.pp.se>
Cc: Xavier Roche <roche+kml2@exalead.com>, linux-kernel@vger.kernel.org,
       vinays@burntmail.com
In-Reply-To: <200508091655.50383.thomas@habets.pp.se>
References: <42F8720D.4060300@picsearch.com>
	 <200508091133.21837.thomas@habets.pp.se>
	 <1123595087.15600.0.camel@localhost.localdomain>
	 <200508091655.50383.thomas@habets.pp.se>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Tue, 09 Aug 2005 17:39:48 +0100
Message-Id: <1123605588.15600.37.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Maw, 2005-08-09 at 16:55 +0200, Thomas Habets wrote:
> Once upon a midnight dreary, Alan Cox pondered, weak and weary:
> > 0 - overcommit except if something is obviously silly
> > 1 - overcommit always (some scientific workloads)
> > 2 - don't overcommit (databases etc)
> 
> Exactly. Which is what the code and D/sysctl/vm.txt say, and why the 
> description in D/filesystems/proc.txt is a lying POS that needs to be 
> *shining blue led in everyones eyes* Exterminated before more people are 
> sucked into its world of lies.

Please submit a patch to fix it

