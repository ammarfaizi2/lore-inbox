Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263291AbSLBNTj>; Mon, 2 Dec 2002 08:19:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263313AbSLBNTj>; Mon, 2 Dec 2002 08:19:39 -0500
Received: from noodles.codemonkey.org.uk ([213.152.47.19]:49320 "EHLO
	noodles.internal") by vger.kernel.org with ESMTP id <S263291AbSLBNTi>;
	Mon, 2 Dec 2002 08:19:38 -0500
Date: Mon, 2 Dec 2002 13:24:39 +0000
From: Dave Jones <davej@codemonkey.org.uk>
To: "J.A. Magallon" <jamagallon@able.es>
Cc: Margit Schubert-While <margitsw@t-online.de>, linux-kernel@vger.kernel.org
Subject: Re: 2.4.19/20, 2.5 missing P4 ifdef ?
Message-ID: <20021202132439.GA26889@suse.de>
Mail-Followup-To: Dave Jones <davej@codemonkey.org.uk>,
	"J.A. Magallon" <jamagallon@able.es>,
	Margit Schubert-While <margitsw@t-online.de>,
	linux-kernel@vger.kernel.org
References: <4.3.2.7.2.20021128151157.00b522c0@pop.t-online.de> <20021128142437.GA23664@suse.de> <20021129000859.GA2027@werewolf.able.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021129000859.GA2027@werewolf.able.es>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 29, 2002 at 01:08:59AM +0100, J.A. Magallon wrote:

 > - PII also supports the prefetches. Is it worth to add it ?

I think you are mistaken. The prefetch instructions came to
Intel CPUs with SSE. There are no (afair) no SSE Pentium II's.

		Dave

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs
