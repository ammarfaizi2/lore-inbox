Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318136AbSIJVHM>; Tue, 10 Sep 2002 17:07:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318132AbSIJVHM>; Tue, 10 Sep 2002 17:07:12 -0400
Received: from e21.nc.us.ibm.com ([32.97.136.227]:46559 "EHLO
	e21.nc.us.ibm.com") by vger.kernel.org with ESMTP
	id <S318136AbSIJVHD>; Tue, 10 Sep 2002 17:07:03 -0400
Subject: Re: [patch] add "If unsure, say N" to CONFIG_X86_TSC_DISABLE
From: john stultz <johnstul@us.ibm.com>
To: Adrian Bunk <bunk@fs.tum.de>
Cc: Marcelo Tosatti <marcelo@conectiva.com.br>,
       lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.NEB.4.44.0209102247150.18902-100000@mimas.fachschaften.tu-muenchen.de>
References: <Pine.NEB.4.44.0209102247150.18902-100000@mimas.fachschaften.tu-muenchen.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 
Date: 10 Sep 2002 14:06:38 -0700
Message-Id: <1031691998.24775.225.camel@cog>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2002-09-10 at 13:53, Adrian Bunk wrote:
> the patch below does:
> - add a "If unsure, say N" to CONFIG_X86_TSC_DISABLE
> - fix two typos

Looks good to me! Thanks!
-john

