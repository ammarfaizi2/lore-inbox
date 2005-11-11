Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751313AbVKKX3r@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751313AbVKKX3r (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Nov 2005 18:29:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751314AbVKKX3r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Nov 2005 18:29:47 -0500
Received: from H190.C26.B96.tor.eicat.ca ([66.96.26.190]:29370 "EHLO
	moraine.clusterfs.com") by vger.kernel.org with ESMTP
	id S1751313AbVKKX3q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Nov 2005 18:29:46 -0500
From: Nikita Danilov <nikita@clusterfs.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17269.10620.891788.767146@gargle.gargle.HOWL>
Date: Sat, 12 Nov 2005 02:30:04 +0300
To: Andi Kleen <ak@suse.de>
Cc: linux-kernel@vger.kernel.org, Arjan van de Ven <arjan@infradead.org>,
       Josh Boyer <jdub@us.ibm.com>, akpm@osdl.org
Subject: Re: [patch] mark text section read-only
Newsgroups: gmane.linux.kernel
In-Reply-To: <200511112243.42255.ak@suse.de>
References: <20051107105624.GA6531@infradead.org>
	<2cd57c900511111057n3a7741ddw@mail.gmail.com>
	<20051111190447.GA14481@everest.sosdg.org>
	<200511112243.42255.ak@suse.de>
X-Mailer: VM 7.17 under 21.5 (patch 17) "chayote" (+CVS-20040321) XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen writes:

[...]

 > 
 > Overall I doubt it is worth it even as a debugging option. I so far cannot
 > remember a single bug that was caused by overwriting kernel text.

I wouldn't forget that one for a long time:

http://marc.theaimsgroup.com/?l=linux-kernel&m=106503116306729&w=2

 > 
 > -Andi
 > 

Nikita.
