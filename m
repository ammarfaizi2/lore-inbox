Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267383AbSLRXeB>; Wed, 18 Dec 2002 18:34:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267390AbSLRXeB>; Wed, 18 Dec 2002 18:34:01 -0500
Received: from holomorphy.com ([66.224.33.161]:48062 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S267383AbSLRXeA>;
	Wed, 18 Dec 2002 18:34:00 -0500
Date: Wed, 18 Dec 2002 15:41:26 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Christoph Hellwig <hch@infradead.org>,
       "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Martin Bligh <mbligh@us.ibm.com>, John Stultz <johnstul@us.ibm.com>,
       "Nakajima, Jun" <jun.nakajima@intel.com>, jamesclv@us.ibm.com,
       "Mallick, Asit K" <asit.k.mallick@intel.com>,
       "Saxena, Sunil" <sunil.saxena@intel.com>
Subject: Re: [PATCH][2.4]  generic cluster APIC support for systems with more than 8 CPUs
Message-ID: <20021218234126.GH1922@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Christoph Hellwig <hch@infradead.org>,
	"Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>,
	Linux Kernel <linux-kernel@vger.kernel.org>,
	Martin Bligh <mbligh@us.ibm.com>, John Stultz <johnstul@us.ibm.com>,
	"Nakajima, Jun" <jun.nakajima@intel.com>, jamesclv@us.ibm.com,
	"Mallick, Asit K" <asit.k.mallick@intel.com>,
	"Saxena, Sunil" <sunil.saxena@intel.com>
References: <C8C38546F90ABF408A5961FC01FDBF1912E18E@fmsmsx405.fm.intel.com> <20021218232640.A1746@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021218232640.A1746@infradead.org>
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 18, 2002 at 11:26:40PM +0000, Christoph Hellwig wrote:
> Except of that the patch looks fine, but IMHO something like that should
> get testing in 2.5 first.

Yes, I'd prefer this happen in 2.5 first and that I and the rest of
everyone in our lab test the living daylights out of it on NUMA-Q.


Bill
