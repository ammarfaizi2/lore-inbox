Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1754475AbWKHJ2h@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754475AbWKHJ2h (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Nov 2006 04:28:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754476AbWKHJ2g
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Nov 2006 04:28:36 -0500
Received: from gwmail.nue.novell.com ([195.135.221.19]:44730 "EHLO
	emea5-mh.id5.novell.com") by vger.kernel.org with ESMTP
	id S1754475AbWKHJ2g (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Nov 2006 04:28:36 -0500
Message-Id: <4551B190.76E4.0078.0@novell.com>
X-Mailer: Novell GroupWise Internet Agent 7.0.1 
Date: Wed, 08 Nov 2006 10:29:36 +0100
From: "Jan Beulich" <jbeulich@novell.com>
To: "Adrian Bunk" <bunk@stusta.de>
Cc: "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
       <discuss@x86-64.org>
Subject: Re: [discuss] 2.6.19-rc5: known regressions
References: <Pine.LNX.4.64.0611071829340.3667@g5.osdl.org>
 <20061108085235.GT4729@stusta.de>
In-Reply-To: <20061108085235.GT4729@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>Subject    : i386: more DWARFs and strange messages
>References : http://lkml.org/lkml/2006/10/29/127 
>Submitter  : Martin Lorenz <martin@lorenz.eu.org>
>Status     : should be fixed by
>             commit 4b96b1a10cb00c867103b21f0f2a6c91b705db11

This commit should be related only to the 'strange messages'; I'm
yet to look into the DWARFs.

Jan
