Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261364AbSKXO4x>; Sun, 24 Nov 2002 09:56:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261354AbSKXO4x>; Sun, 24 Nov 2002 09:56:53 -0500
Received: from holomorphy.com ([66.224.33.161]:63627 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S261364AbSKXO4w>;
	Sun, 24 Nov 2002 09:56:52 -0500
Date: Sun, 24 Nov 2002 07:00:39 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Ed Tomlinson <tomlins@cam.org>
Cc: akpm@digeo.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: hugetlb page patch for 2.5.48-bug fixes
Message-ID: <20021124150039.GB18063@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Ed Tomlinson <tomlins@cam.org>, akpm@digeo.com, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
References: <25282B06EFB8D31198BF00508B66D4FA03EA5B14@fmsmsx114.fm.intel.com> <200211240944.10660.tomlins@cam.org> <20021124144905.GA18063@holomorphy.com> <200211241001.27971.tomlins@cam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200211241001.27971.tomlins@cam.org>
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At some point in the past, I wrote:
>> Okay, you've jumped into oblivion. What fs's were you using here?

On Sun, Nov 24, 2002 at 10:01:27AM -0500, Ed Tomlinson wrote:
> reiserfs.  (sorry about the subject line)

Did you have CONFIG_HUGETLB_FS=y and/or the patch in this thread applied?


Thanks,
Bill
