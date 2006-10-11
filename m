Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030558AbWJKDN7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030558AbWJKDN7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Oct 2006 23:13:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030766AbWJKDN7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Oct 2006 23:13:59 -0400
Received: from e5.ny.us.ibm.com ([32.97.182.145]:11229 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1030558AbWJKDN7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Oct 2006 23:13:59 -0400
Message-ID: <452C616D.7040701@us.ibm.com>
Date: Tue, 10 Oct 2006 20:13:49 -0700
From: Badari Pulavarty <pbadari@us.ibm.com>
User-Agent: Thunderbird 1.5.0.7 (Windows/20060909)
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>, Theodore Tso <tytso@mit.edu>
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.6.19-rc1-mm1
References: <20061010000928.9d2d519a.akpm@osdl.org>
In-Reply-To: <20061010000928.9d2d519a.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.19-rc1/2.6.19-rc1-mm1/
>
>
> - Added the ext4 filesystem.  Quick usage instructions:
>
>   - Grab updated e2fsprogs from
>     ftp://ftp.kernel.org/pub/linux/kernel/people/tytso/e2fsprogs-interim/
>   

Hi Ted,

e2fsprogs-1.39-tyt1-rollup.patch doesn't compile. (seems to be missing 
percent.c). Can
you role up new version ? I had to apply individual patches to get it 
working ..

Thanks,
Badari


