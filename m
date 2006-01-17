Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751280AbWAQPdA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751280AbWAQPdA (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Jan 2006 10:33:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751291AbWAQPdA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Jan 2006 10:33:00 -0500
Received: from wproxy.gmail.com ([64.233.184.197]:50095 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751280AbWAQPc7 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Jan 2006 10:32:59 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=jtwyXEfBvWXuiNXmEUirs7AOpNppws3VEmEIXC5CUqxXEjuPej+b4NUwinRb1pV1seay+zh7K28SAPYRWZu1wk/rovs9so8Pj3zmtqsaEIYiGXnVybSHipCbfS+sObhRO2ZB9rssgZRuqM18vfKoO/OpJhAS0FhvxdfCMGigIi0=
Message-ID: <6bffcb0e0601170732r2d400857i@mail.gmail.com>
Date: Tue, 17 Jan 2006 16:32:58 +0100
From: Michal Piotrowski <michal.k.k.piotrowski@gmail.com>
To: =?ISO-8859-1?Q?Th=E9ophile_Helleboid_-_Chtitux?= 
	<chtitux@gmail.com>
Subject: Re: No kexec in menuconfig in 2.6.16-rc1
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <4c50d3ee0601170530p2cbe98b8k@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
References: <4c50d3ee0601170530p2cbe98b8k@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 17/01/06, Théophile Helleboid - Chtitux <chtitux@gmail.com> wrote:
> Hello,
> I don't see the kexec option on linux-2.6.16-rc1
> I have in my menuconfig :
>      Timer frequency (250 HZ)  --->
> and it's all
> This option has been removed ?
> I can see kexec in the search with /
>
> --
> Chtitux -
> Théophile Helleboid
> -

#
# Code maturity level options
#
CONFIG_EXPERIMENTAL=y
CONFIG_CLEAN_COMPILE=y
CONFIG_LOCK_KERNEL=y

Regards,
Michal Piotrowski
