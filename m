Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264964AbSJWNDi>; Wed, 23 Oct 2002 09:03:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264965AbSJWNDi>; Wed, 23 Oct 2002 09:03:38 -0400
Received: from e4.ny.us.ibm.com ([32.97.182.104]:14060 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S264964AbSJWNDh>;
	Wed, 23 Oct 2002 09:03:37 -0400
Date: Wed, 23 Oct 2002 18:43:17 +0530
From: Ravikiran G Thirumalai <kiran@in.ibm.com>
To: Andrew Morton <akpm@digeo.com>
Cc: lkml <linux-kernel@vger.kernel.org>,
       "linux-mm@kvack.org" <linux-mm@kvack.org>, rusty@rustcorp.com.au
Subject: Re: 2.5.44-mm3
Message-ID: <20021023184317.A32662@in.ibm.com>
References: <3DB6067E.C95174FC@digeo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3DB6067E.C95174FC@digeo.com>; from akpm@digeo.com on Wed, Oct 23, 2002 at 02:17:59AM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
My machine did not boot with CONFIG_NR_CPUS = 4.  Same .config as one
used for 2.5.44-mm2.  Could be the __node_to_cpu_mask redifinition from
the larger-cpu-masks patch .... 

Thanks,
Kiran
