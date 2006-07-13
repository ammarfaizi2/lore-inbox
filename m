Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030300AbWGMTRX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030300AbWGMTRX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jul 2006 15:17:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030298AbWGMTRX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jul 2006 15:17:23 -0400
Received: from py-out-1112.google.com ([64.233.166.180]:21273 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1030300AbWGMTRW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jul 2006 15:17:22 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=YpYh/9MzPNS6kOT2RzzRQTSF/MAve93UuHbUyI8GncEPXlWjpCAm0O9jD1yijRLWTt8XEraeW4cyhttBmUMfWjuIx6Se2ViJLGaVp0XvmlrumwShIG4kfCox6kwhb2NJFb9IGo44HSXhdGeSS7rBPHn99Z0xS0cguD2ax9Ma/eE=
Message-ID: <6bffcb0e0607131217m33107053y108d9f1dcdf8bddb@mail.gmail.com>
Date: Thu, 13 Jul 2006 21:17:21 +0200
From: "Michal Piotrowski" <michal.k.k.piotrowski@gmail.com>
To: "Xiaolan Zhang" <cxzhang@us.ibm.com>
Subject: Re: [PATCH 00/10] Kernel memory leak detector 0.8
Cc: "Catalin Marinas" <catalin.marinas@gmail.com>,
       "Catherine Zhang" <cxzhang@watson.ibm.com>,
       linux-kernel@vger.kernel.org
In-Reply-To: <OF77F433EA.44B73A82-ON852571AA.00677BE7-852571AA.0067A413@us.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <b0943d9e0607120333q7960077veef91d63d826003b@mail.gmail.com>
	 <OF77F433EA.44B73A82-ON852571AA.00677BE7-852571AA.0067A413@us.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Catherine,

On 13/07/06, Xiaolan Zhang <cxzhang@us.ibm.com> wrote:
> Hi, Catalin,
>
> I have identified the problem and will submit a fix soon.

Great, thanks!

>  Could you let
> me know to which tree should I apply the fix against?

2.6.18-rc1.

>
> thanks,
> Catherine
>

Regards,
Michal

-- 
Michal K. K. Piotrowski
LTG - Linux Testers Group
(http://www.stardust.webpages.pl/ltg/wiki/)
