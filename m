Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1755906AbWKVOGq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755906AbWKVOGq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Nov 2006 09:06:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755923AbWKVOGp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Nov 2006 09:06:45 -0500
Received: from nz-out-0102.google.com ([64.233.162.205]:25701 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1755906AbWKVOGp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Nov 2006 09:06:45 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=TI4F8T9yZkVXqMgNK16Vj0w/qrJ+WOogQp6Bxhgap+2ZfBkN/NjGwHLmq+IQQVDULdm2Zih9qT0/VR34HgXTlIApPXwj8DbEPZXPycasKR4W71aB6EgVHCvMh2EDsn+H414DzHXOjmavZvu7VASHM3An8XbN6iyOaPjNXCxQRpw=
Message-ID: <5bdc1c8b0611220606m31c397d1ubafae3460d36db09@mail.gmail.com>
Date: Wed, 22 Nov 2006 06:06:43 -0800
From: "Mark Knecht" <markknecht@gmail.com>
To: "Ingo Molnar" <mingo@elte.hu>
Subject: Re: 2.6.19-rc6-rt5
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20061120220230.GA30835@elte.hu>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20061120220230.GA30835@elte.hu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/20/06, Ingo Molnar <mingo@elte.hu> wrote:
> i've released the 2.6.19-rc6-rt5 tree, which can be downloaded from the
> usual place:
>
>   http://redhat.com/~mingo/realtime-preempt/
>
<SNIP>
>
> as usual, bugreports, fixes and suggestions are welcome,
>
>         Ingo

Ingo,
   I started building the new kernels a few days ago with your
2.6.19-rc6-rt0 announcement. The kernels have built fine but so far I
am unable to build the realtime-lsm package against them so no reason
to reboot.

   I know there were some comments awhile back about being required to
switch to PAM. Has that occurred?

   If not then there is a regression issue for realtime-lsm.

Thanks,
Mark
