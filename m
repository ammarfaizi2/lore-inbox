Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261625AbSJYV77>; Fri, 25 Oct 2002 17:59:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261626AbSJYV77>; Fri, 25 Oct 2002 17:59:59 -0400
Received: from dsl-213-023-039-129.arcor-ip.net ([213.23.39.129]:21163 "EHLO
	starship") by vger.kernel.org with ESMTP id <S261625AbSJYV76>;
	Fri, 25 Oct 2002 17:59:58 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@arcor.de>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       "Nakajima, Jun" <jun.nakajima@intel.com>
Subject: Re: [PATCH] hyper-threading information in /proc/cpuinfo
Date: Sat, 26 Oct 2002 00:06:43 +0200
X-Mailer: KMail [version 1.3.2]
Cc: Robert Love <rml@tech9.net>, "'Dave Jones'" <davej@codemonkey.org.uk>,
       "'akpm@digeo.com'" <akpm@digeo.com>,
       "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
       "'chrisl@vmware.com'" <chrisl@vmware.com>,
       "'Martin J. Bligh'" <mbligh@aracnet.com>
References: <F2DBA543B89AD51184B600508B68D4000ECE7046@fmsmsx103.fm.intel.com> <1035584076.13032.96.camel@irongate.swansea.linux.org.uk>
In-Reply-To: <1035584076.13032.96.camel@irongate.swansea.linux.org.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E185CbL-0008R5-00@starship>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 26 October 2002 00:14, Alan Cox wrote:
> Im just wondering what we would then use to describe a true multiple cpu
> on a die x86. Im curious what the powerpc people think since they have
> this kind of stuff - is there a generic terminology they prefer ?

MIPS also has it, for N=2.

-- 
Daniel
