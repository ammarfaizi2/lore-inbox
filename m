Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267972AbUHKGjo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267972AbUHKGjo (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Aug 2004 02:39:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267967AbUHKGjo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Aug 2004 02:39:44 -0400
Received: from holomorphy.com ([207.189.100.168]:31105 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S267969AbUHKGib (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Aug 2004 02:38:31 -0400
Date: Tue, 10 Aug 2004 23:38:25 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: "Seth, Rohit" <rohit.seth@intel.com>
Cc: "Chen, Kenneth W" <kenneth.w.chen@intel.com>,
       Hirokazu Takahashi <taka@valinux.co.jp>, linux-kernel@vger.kernel.org,
       linux-ia64@vger.kernel.org
Subject: Re: Hugetlb demanding paging for -mm tree
Message-ID: <20040811063825.GP11200@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	"Seth, Rohit" <rohit.seth@intel.com>,
	"Chen, Kenneth W" <kenneth.w.chen@intel.com>,
	Hirokazu Takahashi <taka@valinux.co.jp>,
	linux-kernel@vger.kernel.org, linux-ia64@vger.kernel.org
References: <01EF044AAEE12F4BAAD955CB750649430205DE92@scsmsx401.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <01EF044AAEE12F4BAAD955CB750649430205DE92@scsmsx401.amr.corp.intel.com>
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

William Lee Irwin III <> wrote on Tuesday, August 10, 2004 5:45 PM:
>> Most arches seem to be okay with the API, but it may be more
>> useful/etc. to e.g. explicitly pass the page size, particularly when
>> constant folding is possible.

On Tue, Aug 10, 2004 at 11:36:10PM -0700, Seth, Rohit wrote:
> Are you working on the patch to provide this updated API for
> update_mmu_cache.

No. If you care to write it that would be helpful.


-- wli
