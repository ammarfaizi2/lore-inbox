Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751929AbWCNVww@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751929AbWCNVww (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Mar 2006 16:52:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751944AbWCNVww
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Mar 2006 16:52:52 -0500
Received: from duke.cs.duke.edu ([152.3.140.1]:35064 "EHLO duke.cs.duke.edu")
	by vger.kernel.org with ESMTP id S1751929AbWCNVwv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Mar 2006 16:52:51 -0500
Date: Tue, 14 Mar 2006 16:52:45 -0500 (EST)
From: Tong Li <tongli@cs.duke.edu>
To: Avishay Traeger <atraeger@cs.sunysb.edu>
cc: linux-kernel@vger.kernel.org
Subject: Re: Bursty I/O in ext3
In-Reply-To: <1142354805.7079.2.camel@rockstar.fsl.cs.sunysb.edu>
Message-ID: <Pine.GSO.4.62.0603141651230.4481@eenie.cs.duke.edu>
References: <Pine.GSO.4.62.0603140150420.1352@eenie.cs.duke.edu>
 <1142354805.7079.2.camel@rockstar.fsl.cs.sunysb.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I tried to recreate the condition, but failed (10 runs, all about the
> same amount of time).  Is it possible that you have some other process
> accessing the partition?

I don't have other processes running on the system, so I don't know...

Thanks,

   tong
