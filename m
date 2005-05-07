Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262949AbVEGKSd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262949AbVEGKSd (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 May 2005 06:18:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262952AbVEGKSd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 May 2005 06:18:33 -0400
Received: from willy.net1.nerim.net ([62.212.114.60]:55561 "EHLO
	willy.net1.nerim.net") by vger.kernel.org with ESMTP
	id S262949AbVEGKSb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 May 2005 06:18:31 -0400
Date: Sat, 7 May 2005 12:09:26 +0200
From: Willy Tarreau <willy@w.ods.org>
To: Dimitris Zilaskos <dzila@tassadar.physics.auth.gr>
Cc: Marcelo Tosatti <marcelo.tosatti@cyclades.com>, openafs-info@openafs.org,
       linux-kernel@vger.kernel.org
Subject: Re: Openafs 1.3.78 and kernel 2.4.29 oopses , same for 2.4.30 and openafs 1.3.82
Message-ID: <20050507100926.GA18418@alpha.home.local>
References: <Pine.LNX.4.62.0505060209040.31479@tassadar.physics.auth.gr> <20050506052803.GE777@alpha.home.local> <20050506165033.GA2105@logos.cnet> <Pine.LNX.4.62.0505071245500.7641@tassadar.physics.auth.gr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.62.0505071245500.7641@tassadar.physics.auth.gr>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 07, 2005 at 12:51:27PM +0300, Dimitris Zilaskos wrote:
> 
> 	I have just completed 24 hours of uptime with 2.4.29-hf , openafs 
> 1.3.78 , with openafs in full use , and no oops occured. My next step now 
> will be moving to 2.4.30 and see how it goes.

Dimitris,

please try 2.4.30 with openafs 1.3.78 (I don't know if the patch applies
cleanly). It will help determining which of kernel and openafs upgrades
bring the problem.

Cheers,
Willy

