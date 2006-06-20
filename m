Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751254AbWFTOv0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751254AbWFTOv0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jun 2006 10:51:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751191AbWFTOv0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jun 2006 10:51:26 -0400
Received: from wr-out-0506.google.com ([64.233.184.230]:27024 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1751254AbWFTOvZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jun 2006 10:51:25 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=DsMgZRyA4QyK19pPBcYM1Wj/Sn6lU/BPs034s7EagOcHjU8et8s7LUFNNhg7TMZNOi/Fq5DQnCC1cXoXBxvMwhfr6IOOXeae/3Iv4SV4rRkxZW5410Huc4kGPYOzKTUw2vC7FY8v5tYfAPrvFFsP123lQx17uUlbmR6y6oFJvac=
Message-ID: <6bffcb0e0606200751i65046a51o9740f57cb4bcf72b@mail.gmail.com>
Date: Tue, 20 Jun 2006 16:51:19 +0200
From: "Michal Piotrowski" <michal.k.k.piotrowski@gmail.com>
To: tglx@timesys.com
Subject: Re: [PATCHSET] Announce: High-res timers, tickless/dyntick and dynamic HZ -V4
Cc: LKML <linux-kernel@vger.kernel.org>, "Ingo Molnar" <mingo@elte.hu>,
       "Andrew Morton" <akpm@osdl.org>, "Con Kolivas" <kernel@kolivas.org>
In-Reply-To: <1150747581.29299.75.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <1150747581.29299.75.camel@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 19/06/06, Thomas Gleixner <tglx@timesys.com> wrote:
> An updated patchset is available from:
>
> http://www.tglx.de/projects/hrtimers/2.6.17/patch-2.6.17-hrt-dyntick4.patch
[snip]
> - minor fixups e.g. APM breakage

Problem fixed, thanks.

>         Thomas, Ingo

Regards,
Michal

-- 
Michal K. K. Piotrowski
LTG - Linux Testers Group
(http://www.stardust.webpages.pl/ltg/wiki/)
