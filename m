Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030387AbWHRN4A@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030387AbWHRN4A (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Aug 2006 09:56:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030399AbWHRN4A
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Aug 2006 09:56:00 -0400
Received: from py-out-1112.google.com ([64.233.166.177]:7928 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1030387AbWHRNz7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Aug 2006 09:55:59 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=HXmZoF5Km6SV7OrxT2B6BViWPm7flOKCa3bGmcvOxxB0lsVEU8CXVx17rA5uxUVPTnq00xJkFhJb6YgnwR8d5N61Pw4GK8jDPL1159cXNjizg2sv45WWb1XmSiGpvCYjk587VALeSMYjwjkGcCugqrztYvgRN9lQKtTBXGgomFU=
Message-ID: <6bffcb0e0608180655j50332247m8ed393c37d570ee4@mail.gmail.com>
Date: Fri, 18 Aug 2006 15:55:59 +0200
From: "Michal Piotrowski" <michal.k.k.piotrowski@gmail.com>
To: "Catalin Marinas" <catalin.marinas@gmail.com>
Subject: Re: [PATCH 2.6.18-rc4 00/10] Kernel memory leak detector 0.9
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <b0943d9e0608180627g61007207read993387bf0c0b4@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20060812215857.17709.79502.stgit@localhost.localdomain>
	 <6bffcb0e0608130459k1c7e142esbfc2439badf323bd@mail.gmail.com>
	 <b0943d9e0608130713j1e4a8836i943d31011169cf05@mail.gmail.com>
	 <6bffcb0e0608130726x8fc1c0v7717165a63391e80@mail.gmail.com>
	 <b0943d9e0608170602v13dea49bgf64dbf17b7a52273@mail.gmail.com>
	 <6bffcb0e0608170745s8145df4ya4e946c76ab83c1b@mail.gmail.com>
	 <b0943d9e0608170801v23592952scf12c2c0b4a7bf4@mail.gmail.com>
	 <b0943d9e0608171458l45b717bexbfb8fb2ba68228db@mail.gmail.com>
	 <6bffcb0e0608180528ocadc36ck8868ae1a33342bb9@mail.gmail.com>
	 <b0943d9e0608180627g61007207read993387bf0c0b4@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 18/08/06, Catalin Marinas <catalin.marinas@gmail.com> wrote:
> On 18/08/06, Michal Piotrowski <michal.k.k.piotrowski@gmail.com> wrote:
> > Something doesn't work. It appears while udev start.
>
> Could you try the attached patch? It has some improvements from the
> yesterday's one and also prints extra information when that error
> happens.

Problem fixed, thank. I'll do some tests.

>
> Thanks.
>
> --
> Catalin
>
>
>

Regards,
Michal

-- 
Michal K. K. Piotrowski
LTG - Linux Testers Group
(http://www.stardust.webpages.pl/ltg/wiki/)
