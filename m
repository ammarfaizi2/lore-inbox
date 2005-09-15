Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751009AbVIODar@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751009AbVIODar (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Sep 2005 23:30:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751034AbVIODar
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Sep 2005 23:30:47 -0400
Received: from tuminfo2.informatik.tu-muenchen.de ([131.159.0.81]:19951 "EHLO
	tuminfo2.informatik.tu-muenchen.de") by vger.kernel.org with ESMTP
	id S1751009AbVIODaq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Sep 2005 23:30:46 -0400
Message-ID: <4328EC72.6050507@in.tum.de>
Date: Thu, 15 Sep 2005 05:37:22 +0200
From: Daniel Thaler <thalerd@in.tum.de>
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050803)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Lee Revell <rlrevell@joe-job.com>
Cc: David Lang <dlang@digitalinsight.com>, Hua Zhong <hzhong@gmail.com>,
       marekw1977@yahoo.com.au, linux-kernel@vger.kernel.org
Subject: Re: Automatic Configuration of a Kernel
References: <20050914223836.53814.qmail@web51011.mail.yahoo.com>	 <6bffcb0e05091415533d563c5a@mail.gmail.com><4328B710.5080503@in.tum.de>	 <200509151009.59981.marekw1977@yahoo.com.au>	 <924c288305091417375fea4ec2@mail.gmail.com>	 <Pine.LNX.4.62.0509141900280.8469@qynat.qvtvafvgr.pbz> <1126753444.13893.123.camel@mindpipe>
In-Reply-To: <1126753444.13893.123.camel@mindpipe>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Lee Revell wrote:
> Why does this have to be in the kernel again?  Isn't this exactly what
> you get with a fully modular config and hotplug?

It doesn't go in the kernel. If I understand correctly, it's a script that is 
invoked by 'make autoconfig'. Note that I didn't read the patch, because it's a 
.tgz on a website and I couldn't be bothered to download it.

Daniel
