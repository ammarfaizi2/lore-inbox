Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269373AbUIYM5r@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269373AbUIYM5r (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Sep 2004 08:57:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269422AbUIYM5q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Sep 2004 08:57:46 -0400
Received: from holomorphy.com ([207.189.100.168]:47592 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S269373AbUIYM5N (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Sep 2004 08:57:13 -0400
Date: Sat, 25 Sep 2004 05:57:07 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Zwane Mwaikambo <zwane@linuxpower.ca>
Cc: Borislav Petkov <petkov@uni-muenster.de>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: OOM-killer killed everything
Message-ID: <20040925125707.GO9106@holomorphy.com>
References: <200409251326.13915.petkov@uni-muenster.de> <20040925124441.GM9106@holomorphy.com> <Pine.LNX.4.53.0409251553420.11618@musoma.fsmlabs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.53.0409251553420.11618@musoma.fsmlabs.com>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 25 Sep 2004, William Lee Irwin III wrote:
>> Usually I only get "Kernel panic: Out of memory and no killable processes..."
>> from local DoS testcases; I'd be surprised if anyone tripped over such
>> cases by accident unless they're doing something particularly stressful
>> (e.g. forking server with zillions of clients) or there's a
>> particularly outrageously offensive memory leak.
>
On Sat, Sep 25, 2004 at 03:54:59PM +0300, Zwane Mwaikambo wrote:
> The burning CD audio one is a known issue afaik, i've run into it before 
> too.

That would be the particularly outrageously offensive memory leak, then.


-- wli
