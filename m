Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750748AbWIUARS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750748AbWIUARS (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Sep 2006 20:17:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750811AbWIUARS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Sep 2006 20:17:18 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:11212 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S1750748AbWIUARS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Sep 2006 20:17:18 -0400
Date: Wed, 20 Sep 2006 17:17:04 -0700
From: Paul Jackson <pj@sgi.com>
To: "Paul Menage" <menage@google.com>
Cc: alan@lxorguk.ukuu.org.uk, clameter@sgi.com, npiggin@suse.de,
       ckrm-tech@lists.sourceforge.net, linux-kernel@vger.kernel.org,
       rohitseth@google.com, devel@openvz.org
Subject: Re: [ckrm-tech] [patch00/05]: Containers(V2)- Introduction
Message-Id: <20060920171704.4115996f.pj@sgi.com>
In-Reply-To: <6599ad830609201710q4ab1cd18lf4ef3c6534e06338@mail.google.com>
References: <1158718568.29000.44.camel@galaxy.corp.google.com>
	<Pine.LNX.4.64.0609200916140.30572@schroedinger.engr.sgi.com>
	<1158773699.7705.19.camel@localhost.localdomain>
	<6599ad830609201030w38b6ae59ia0d4a4ccabb47054@mail.google.com>
	<20060920163722.1442c5c1.pj@sgi.com>
	<6599ad830609201653g4f44a4frb308eaeb63f83d2a@mail.google.com>
	<20060920170759.c31c0596.pj@sgi.com>
	<6599ad830609201710q4ab1cd18lf4ef3c6534e06338@mail.google.com>
Organization: SGI
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.3; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paul M:
> It doesn't have to be linked to cpusets - but userspace could use it
> in conjunction with cpusets to control/account pagecache memory
> sharing.

Could be.  Right now I'm feeling too lazy to think about this hard
enough to be useful.

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.925.600.0401
