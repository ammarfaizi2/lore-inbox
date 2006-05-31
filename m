Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751730AbWEaQsQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751730AbWEaQsQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 May 2006 12:48:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751734AbWEaQsQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 May 2006 12:48:16 -0400
Received: from nf-out-0910.google.com ([64.233.182.186]:473 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1751731AbWEaQsP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 May 2006 12:48:15 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Nbg3sjgHVaYLPvN706LApv3xC7PfafflIfjThOIGktUvjQSO6CrHe39Y9RW7xwE1JGYe2KIn3Hsi83Q4BAmWfoLsd0dfrxpSOpBHbvumfhlwbsb0M/hcI2ZZ92k8kZXz5l3TtBY0gG8A4LeYmxJT80HheZe7Ew5rI3In3ovW/cM=
Message-ID: <4807377b0605310948h47c035f4q8f07a9c1a5bea993@mail.gmail.com>
Date: Wed, 31 May 2006 09:48:13 -0700
From: "Jesse Brandeburg" <jesse.brandeburg@gmail.com>
To: "Andrew Morton" <akpm@osdl.org>, mingo@elte.hu
Subject: Re: 2.6.17-rc5-mm1
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20060530022925.8a67b613.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20060530022925.8a67b613.akpm@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/30/06, Andrew Morton <akpm@osdl.org> wrote:
>
> - Merged the runtime locking validator.  If you enable this your machine
>   will run slowly.

The help in menuconfig mentions that a user looking for more info
should reference Documentation/locking-correctness.txt which doesn't
exist.

Jesse
