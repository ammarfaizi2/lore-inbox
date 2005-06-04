Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261312AbVFDOfR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261312AbVFDOfR (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Jun 2005 10:35:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261315AbVFDOfR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Jun 2005 10:35:17 -0400
Received: from dvhart.com ([64.146.134.43]:46759 "EHLO localhost.localdomain")
	by vger.kernel.org with ESMTP id S261312AbVFDOfK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Jun 2005 10:35:10 -0400
Date: Sat, 04 Jun 2005 07:35:11 -0700
From: "Martin J. Bligh" <mbligh@mbligh.org>
Reply-To: "Martin J. Bligh" <mbligh@mbligh.org>
To: Andrew Morton <akpm@osdl.org>, Jeff Garzik <jgarzik@pobox.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.12?
Message-ID: <398710000.1117895711@[10.10.2.4]>
In-Reply-To: <394120000.1117895039@[10.10.2.4]>
References: <42A0D88E.7070406@pobox.com> <20050603163843.1cf5045d.akpm@osdl.org> <394120000.1117895039@[10.10.2.4]>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



--"Martin J. Bligh" <mbligh@mbligh.org> wrote (on Saturday, June 04, 2005 07:23:59 -0700):

> 
> 
> --Andrew Morton <akpm@osdl.org> wrote (on Friday, June 03, 2005 16:38:43 -0700):
> 
>> Jeff Garzik <jgarzik@pobox.com> wrote:
>>> 
>>> 
>>> So...  are we gonna see 2.6.12 sometime soon?
>>> 
>> 
>> Current plan is -rc6 in a few days, 2.6.12 a week after that.
>> 
>> 
>> My things-to-worry-about folder still has 244 entries.  Nobody seems to
>> care much.  Poor me.
>> 
>> Lots of USB problems, quite a few input problems.  fbdev, ACPI, ATAPI.  All
>> the usual suspects.
> 
> The one that worries me is that my x86_64 box won't boot since -rc3
> See:
> 
> http://ftp.kernel.org/pub/linux/kernel/people/mbligh/abat/regression_matrix.html
> 
> Note large amount of red in left hand column. Backing out the fusion
> patches to the previous rev didn't fix it.

Filed bug 4709 to track it.

M.

