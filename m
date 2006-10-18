Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750990AbWJRK7L@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750990AbWJRK7L (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Oct 2006 06:59:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030191AbWJRK7L
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Oct 2006 06:59:11 -0400
Received: from cantor2.suse.de ([195.135.220.15]:50836 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1750990AbWJRK7K (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Oct 2006 06:59:10 -0400
From: Andi Kleen <ak@suse.de>
To: eranian@hpl.hp.com
Subject: Re: [PATCH] x86-64 add Intel Core related PMU MSRs
Date: Wed, 18 Oct 2006 12:46:05 +0200
User-Agent: KMail/1.9.3
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org
References: <20061018092536.GA19522@frankl.hpl.hp.com>
In-Reply-To: <20061018092536.GA19522@frankl.hpl.hp.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200610181246.05886.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 18 October 2006 11:25, Stephane Eranian wrote:
> Hello,
> 
> The following patch adds to the x86-64 tree a bunch of MSRs related to performance
> monitoring for the processors based on Intel Core microarchitecture. It also adds
> some architectural MSRs for PEBS. A similar patch for i386 will follow.
> 
> changelog:
> 	- add Intel Precise-Event Based sampling (PEBS) related MSR
> 	- add Intel Data Save (DS) Area related MSR
> 	- add Intel Core microarchitecure performance counter MSRs

Added thanks
-Andi
