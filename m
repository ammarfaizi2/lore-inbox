Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270644AbTHAAaZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Jul 2003 20:30:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S274867AbTHAAaZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Jul 2003 20:30:25 -0400
Received: from [66.212.224.118] ([66.212.224.118]:43277 "EHLO
	hemi.commfireservices.com") by vger.kernel.org with ESMTP
	id S270644AbTHAAaV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Jul 2003 20:30:21 -0400
Date: Thu, 31 Jul 2003 20:18:41 -0400 (EDT)
From: Zwane Mwaikambo <zwane@arm.linux.org.uk>
X-X-Sender: zwane@montezuma.mastecende.com
To: William Lee Irwin III <wli@holomorphy.com>
Cc: Andrew Morton <akpm@osdl.org>, mbligh@aracnet.com,
       linux-kernel@vger.kernel.org
Subject: Re: Panic on 2.6.0-test1-mm1
In-Reply-To: <20030801001538.GK15452@holomorphy.com>
Message-ID: <Pine.LNX.4.53.0307312012170.3779@montezuma.mastecende.com>
References: <5110000.1059489420@[10.10.2.4]> <20030731223710.GI15452@holomorphy.com>
 <20030731224148.GJ15452@holomorphy.com> <20030731154020.61e15723.akpm@osdl.org>
 <20030801001538.GK15452@holomorphy.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 31 Jul 2003, William Lee Irwin III wrote:

> I don't believe it would be valuable to push it on the grounds of
> performance, as the performance characteristics of modern midrange i386
> systems don't have such high remote access penalties.

Others might be interested to know about the effects (performance, memory 
consumption etc) nonetheless, regardless of how large or negligible. It 
helps in finding out where to start looking when things improve (or regress).

Thanks for the work anyway,
	Zwane
-- 
function.linuxpower.ca
