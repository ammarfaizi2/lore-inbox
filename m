Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264844AbTBTFHH>; Thu, 20 Feb 2003 00:07:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264875AbTBTFHH>; Thu, 20 Feb 2003 00:07:07 -0500
Received: from holomorphy.com ([66.224.33.161]:19613 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S264844AbTBTFHG>;
	Thu, 20 Feb 2003 00:07:06 -0500
Date: Wed, 19 Feb 2003 21:16:13 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: "Martin J. Bligh" <mbligh@aracnet.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       lse-tech <lse-tech@lists.sourceforge.net>
Subject: Re: [Lse-tech] Re: Performance of partial object-based rmap
Message-ID: <20030220051613.GG22687@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	"Martin J. Bligh" <mbligh@aracnet.com>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	lse-tech <lse-tech@lists.sourceforge.net>
References: <7490000.1045715152@[10.10.2.4]> <20030220044748.GE22687@holomorphy.com> <32200000.1045718048@[10.10.2.4]>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <32200000.1045718048@[10.10.2.4]>
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At some point in the past, I wrote:
>> Could I get a larger, multiplicative differential profile?
>> i.e. ratios of the fractions of profile hits?
>> If you have trouble generating such I can do so myself from
>> fuller profile results.

On Wed, Feb 19, 2003 at 09:14:10PM -0800, Martin J. Bligh wrote:
> before:
> 	187256 total
> after:
> 	170196 total

Well, I was trying to get an idea of what got slower to compensate
for the improvement in page_(add|remove)_rmap() times.


-- wli
