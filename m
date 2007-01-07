Return-Path: <linux-kernel-owner+w=401wt.eu-S932337AbXAGCQQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932337AbXAGCQQ (ORCPT <rfc822;w@1wt.eu>);
	Sat, 6 Jan 2007 21:16:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932345AbXAGCQP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Jan 2007 21:16:15 -0500
Received: from nf-out-0910.google.com ([64.233.182.185]:28801 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932339AbXAGCQN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Jan 2007 21:16:13 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=AtgMuEHF2k8BtHzdgdeOZfhFkkfrsRqz1xBpEHxK5+CNMdDSOCJxMHrGSQVtat2jL6E21jd/KKcq0O/6J+RLi+HrV55CmnS1PAn3aBJEYVhHqbcffnpA2OS8P2zDqONvQeBqzvYRie2DeMH4xBK5t+Ymbmge0fjyeq5V3QHSy3U=
Message-ID: <58cb370e0701061816s308155abw719a00d499f504ea@mail.gmail.com>
Date: Sun, 7 Jan 2007 03:16:12 +0100
From: "Bartlomiej Zolnierkiewicz" <bzolnier@gmail.com>
To: "Conke Hu" <conke.hu@gmail.com>
Subject: Re: [PATCH 3/3] atiixp.c: add cable detection support for ATI IDE
Cc: "Linux kernel mailing list" <linux-kernel@vger.kernel.org>,
       "Andrew Morton" <akpm@osdl.org>, "Greg KH" <greg@kroah.com>
In-Reply-To: <5767b9100701060422p1abd1d21x606b758220815551@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <5767b9100701060422p1abd1d21x606b758220815551@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/6/07, Conke Hu <conke.hu@gmail.com> wrote:
> IDE HDD does not work if it uses a 40-pin PATA cable on ATI chipset.
> This patch fixes the bug.
>
> Signed-off-by: Conke Hu <conke.hu@amd.com>

Acked-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

[ the one is also line wrapped, please resend them ]
