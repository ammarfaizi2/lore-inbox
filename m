Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267625AbUGWK6g@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267625AbUGWK6g (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jul 2004 06:58:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267626AbUGWK6f
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jul 2004 06:58:35 -0400
Received: from mproxy.gmail.com ([216.239.56.245]:33363 "EHLO mproxy.gmail.com")
	by vger.kernel.org with ESMTP id S267625AbUGWK60 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jul 2004 06:58:26 -0400
Message-ID: <4d8e3fd30407230358141e0e58@mail.gmail.com>
Date: Fri, 23 Jul 2004 12:58:22 +0200
From: Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com>
To: Ingo Molnar <mingo@elte.hu>
Subject: Re: [patch] voluntary-preempt-2.6.8-rc2-I3
Cc: linux-kernel@vger.kernel.org, Rudo Thomas <rudo@matfyz.cz>,
       Matt Heler <lkml@lpbproductions.com>
In-Reply-To: <20040723104246.GA2752@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <20040721211826.GB30871@elte.hu> <20040721223749.GA2863@yoda.timesys> <20040722100657.GA14909@elte.hu> <20040722160055.GA4837@ss1000.ms.mff.cuni.cz> <20040722161941.GA23972@elte.hu> <20040722172428.GA5632@ss1000.ms.mff.cuni.cz> <20040722175457.GA5855@ss1000.ms.mff.cuni.cz> <20040722180142.GC30059@elte.hu> <20040722180821.GA377@elte.hu> <20040722181426.GA892@elte.hu> <20040723104246.GA2752@elte.hu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 23 Jul 2004 12:42:46 +0200, Ingo Molnar <mingo@elte.hu> wrote:
> 
> i've uploaded the -I3 voluntary-preempt patch:
> 
>  http://redhat.com/~mingo/voluntary-preempt/voluntary-preempt-2.6.8-rc2-I3
> 
> it mainly fixes an ext3 livelock that could result in long delays during
> heavy commit traffic.

Hello Ingo,
do you have any measurement of the improvement available ?

Thanks.

Ciao,
                     Paolo


-- 
paoloc.doesntexist.org
