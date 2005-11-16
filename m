Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030225AbVKPIgz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030225AbVKPIgz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Nov 2005 03:36:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030230AbVKPIgz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Nov 2005 03:36:55 -0500
Received: from mx2.suse.de ([195.135.220.15]:8860 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1030225AbVKPIgy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Nov 2005 03:36:54 -0500
From: Andi Kleen <ak@suse.de>
To: Magnus Damm <magnus.damm@gmail.com>
Subject: Re: [PATCH 01/05] NUMA: Generic code
Date: Wed, 16 Nov 2005 09:38:14 +0100
User-Agent: KMail/1.8.2
Cc: Magnus Damm <magnus@valinux.co.jp>, linux-mm@kvack.org,
       linux-kernel@vger.kernel.org, pj@sgi.com, werner@almesberger.net
References: <20051110090920.8083.54147.sendpatchset@cherry.local> <p73sltxowx4.fsf@verdi.suse.de> <aec7e5c30511152357g560127c6n88d0bce3b5a2f4e@mail.gmail.com>
In-Reply-To: <aec7e5c30511152357g560127c6n88d0bce3b5a2f4e@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200511160938.14992.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 16 November 2005 08:57, Magnus Damm wrote:

> 
> Sorry, but which one did not work very well? CKRM memory controller or
> NUMA emulation + CPUSETS?

Using simulated nodes for controlling memory.

-Andi
