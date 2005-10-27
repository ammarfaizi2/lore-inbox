Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932246AbVJ0VGI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932246AbVJ0VGI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Oct 2005 17:06:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932257AbVJ0VGI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Oct 2005 17:06:08 -0400
Received: from twin.uoregon.edu ([128.223.214.27]:6056 "EHLO twin.uoregon.edu")
	by vger.kernel.org with ESMTP id S932246AbVJ0VGH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Oct 2005 17:06:07 -0400
Date: Thu, 27 Oct 2005 14:06:00 -0700 (PDT)
From: Joel Jaeggli <joelja@darkwing.uoregon.edu>
X-X-Sender: joelja@twin.uoregon.edu
To: Vladimir Lazarenko <vlad@lazarenko.net>
cc: linux-kernel@vger.kernel.org
Subject: Re: AMD Athlon64 X2 Dual-core and 4GB
In-Reply-To: <4361408B.60903@lazarenko.net>
Message-ID: <Pine.LNX.4.64.0510271403520.25823@twin.uoregon.edu>
References: <4361408B.60903@lazarenko.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 27 Oct 2005, Vladimir Lazarenko wrote:

> Hello,
>
> Looking at the thread of Interl Dual-core and 4GB a sudden thought came to my 
> mind: "Hey, I'm gonna upgrade my box to 4G next week too... Would it work?"
>
> Thus, the question - would I be able to use whole 4G RAM with dual-core amd 
> and kernel with SMP compiled for i686?

Yes but you would only be able to malloc 3GB per process. Go with the 
x86_64 kernel and that goes away. we have x86_x64's with 16GB of ram.

> Thanks in advance!
>
> Vladimir
>

-- 
--------------------------------------------------------------------------
Joel Jaeggli  	       Unix Consulting 	       joelja@darkwing.uoregon.edu
GPG Key Fingerprint:     5C6E 0104 BAF0 40B0 5BD3 C38B F000 35AB B67F 56B2

