Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422857AbWJVApy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422857AbWJVApy (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Oct 2006 20:45:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422862AbWJVApy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Oct 2006 20:45:54 -0400
Received: from smtp.bulldogdsl.com ([212.158.248.8]:15110 "EHLO
	mcr-smtp-002.bulldogdsl.com") by vger.kernel.org with ESMTP
	id S1422857AbWJVApx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Oct 2006 20:45:53 -0400
X-Spam-Abuse: Please report all spam/abuse matters to abuse@bulldogdsl.com
From: Alistair John Strachan <s0348365@sms.ed.ac.uk>
To: "Linux Portal" <linportal@gmail.com>
Subject: Re: First benchmarks of the ext4 file system
Date: Sun, 22 Oct 2006 01:45:55 +0100
User-Agent: KMail/1.9.5
Cc: linux-kernel@vger.kernel.org
References: <ceccffee0610211657u66b758b7r78fbf1c75f5dea67@mail.gmail.com>
In-Reply-To: <ceccffee0610211657u66b758b7r78fbf1c75f5dea67@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200610220145.55497.s0348365@sms.ed.ac.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 22 October 2006 00:57, Linux Portal wrote:
> ext4 is 20 percent faster writer than ext3 or reiser4, probably thanks
> to extents and delayed allocation. On other tests it is either
> slightly faster or slightly slower. reiser4 comes as a nice surprise,
> winning few benchmarks. Both are very stable, no errors during
> testing.
>
> http://linux.inet.hr/first_benchmarks_of_the_ext4_file_system.html

If you get a chance, some similar benchmarks including other major filesystems 
like JFS, XFS and ReiserFS3 would be nice. People keep using the same old 
results but don't realise performance of Linux filesystems changes from 
kernel to kernel..

-- 
Cheers,
Alistair.

Final year Computer Science undergraduate.
1F2 55 South Clerk Street, Edinburgh, UK.
