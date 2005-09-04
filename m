Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751150AbVIDH3W@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751150AbVIDH3W (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Sep 2005 03:29:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751181AbVIDH3V
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Sep 2005 03:29:21 -0400
Received: from mxfep02.bredband.com ([195.54.107.73]:9969 "EHLO
	mxfep02.bredband.com") by vger.kernel.org with ESMTP
	id S1751150AbVIDH3V (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Sep 2005 03:29:21 -0400
Message-ID: <431AA3E2.8020909@stesmi.com>
Date: Sun, 04 Sep 2005 09:36:02 +0200
From: Stefan Smietanowski <stesmi@stesmi.com>
User-Agent: Mozilla Thunderbird 1.0.2 (Windows/20050317)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Lee Revell <rlrevell@joe-job.com>
CC: Adrian Bunk <bunk@stusta.de>, linux-kernel@vger.kernel.org,
       reiserfs-dev@namesys.com
Subject: Re: RFC: i386: kill !4KSTACKS
References: <20050902003915.GI3657@stusta.de> <1125805704.14032.71.camel@mindpipe>
In-Reply-To: <1125805704.14032.71.camel@mindpipe>
X-Enigmail-Version: 0.92.0.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-AntiVirus: checked by Vexira Milter 1.0.7; VAE 6.29.0.5; VDF 6.29.0.100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Lee Revell wrote:
> On Fri, 2005-09-02 at 02:39 +0200, Adrian Bunk wrote:
> 
>>4Kb kernel stacks are the future on i386, and it seems the problems it
>>initially caused are now sorted out.
>>
>>Does anyone knows about any currently unsolved problems?
> 
> 
> ndiswrapper

While I agree ndiswrapper has a use ... I don't think we should
base kernel development upon messing with something that is designed
to run a windows driver in linux ...

// Stefan
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (MingW32)

iD8DBQFDGqPiBrn2kJu9P78RAgO4AJ9r6FNwB+72iRmdcMoxP0vi8gTDUQCfeUG5
5Qbcq/o/Zao79JPEVqOmH+M=
=xpUz
-----END PGP SIGNATURE-----
