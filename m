Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267341AbSKSVck>; Tue, 19 Nov 2002 16:32:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267348AbSKSVck>; Tue, 19 Nov 2002 16:32:40 -0500
Received: from svr-ganmtc-appserv-mgmt.ncf.coxexpress.com ([24.136.46.5]:20232
	"EHLO svr-ganmtc-appserv-mgmt.ncf.coxexpress.com") by vger.kernel.org
	with ESMTP id <S267341AbSKSVci>; Tue, 19 Nov 2002 16:32:38 -0500
Subject: Re: [BENCHMARK] 2.5.48-mm1 with contest
From: Robert Love <rml@tech9.net>
To: Con Kolivas <conman@kolivas.net>
Cc: linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@digeo.com>
In-Reply-To: <1037741326.3ddaad0ef119d@kolivas.net>
References: <1037741326.3ddaad0ef119d@kolivas.net>
Content-Type: text/plain
Organization: 
Message-Id: <1037741983.1504.2229.camel@phantasy>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.0 
Date: 19 Nov 2002 16:39:43 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2002-11-19 at 16:28, Con Kolivas wrote:

> xtar_load:
> Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
> 2.5.48 [5]              184.4   41      2       6       2.52
> 2.5.48-mm1 [5]          210.7   35      2       6       2.88
>
> read_load:
> Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
> 2.5.48 [5]              102.9   74      6       4       1.41
> 2.5.48-mm1 [5]          256.7   29      11      2       3.51*

What changed, Andrew?

Wall time is up but CPU is down... spending more time on I/O?

Con, mind refreshing me on what the LCPU% and Ratio columns mean?

Thanks,

	Robert Love

