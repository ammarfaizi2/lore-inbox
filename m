Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751638AbWJIRoG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751638AbWJIRoG (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Oct 2006 13:44:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750875AbWJIRoF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Oct 2006 13:44:05 -0400
Received: from ug-out-1314.google.com ([66.249.92.168]:12446 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S932272AbWJIRoC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Oct 2006 13:44:02 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=XlVns/oFt3G6i2qJkg/0UrGbcJJp+Hvc34AIKO7VvQQJVEL4xflw+Wjprb0fm+0Ml9ECrgv7agHKv93m58Ohen8d3SoGycsgV1FsRKFCjc3sYqvWsrkAUdAZUYY35zvIN2lXKIVemQgAOAgEV3+Xt6SWbBCvI4NBc2kttJ4dJmg=
Message-ID: <6bffcb0e0610091044he5240xad5b7a48d20c2c56@mail.gmail.com>
Date: Mon, 9 Oct 2006 19:44:00 +0200
From: "Michal Piotrowski" <michal.k.k.piotrowski@gmail.com>
To: "Catalin Marinas" <catalin.marinas@gmail.com>
Subject: Re: [PATCH 2.6.19-rc1 00/10] Kernel memory leak detector 0.11
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <6bffcb0e0610090718x185cc03cv20a117cf8f3c45e@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20061009124813.2695.8123.stgit@localhost.localdomain>
	 <6bffcb0e0610090718x185cc03cv20a117cf8f3c45e@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/10/06, Michal Piotrowski <michal.k.k.piotrowski@gmail.com> wrote:
> Hi Catalin,
>
> On 09/10/06, Catalin Marinas <catalin.marinas@gmail.com> wrote:
> > This is a new version (0.11) of the kernel memory leak detector. See
> > the Documentation/kmemleak.txt file for a more detailed
> > description. The patches are downloadable from (the whole patch or the
> > broken-out series):
> >
> > http://homepage.ntlworld.com/cmarinas/kmemleak/patch-2.6.19-rc1-kmemleak-0.11.bz2
> > http://homepage.ntlworld.com/cmarinas/kmemleak/broken-out/patches-kmemleak-0.11.tar.bz2
>
> I have a new false positives :)
> http://www.stardust.webpages.pl/files/o_bugs/kmemleak-0.11/ml.txt

KML vs. Autotest
http://www.stardust.webpages.pl/files/o_bugs/kmemleak-0.11/kml-vs-autotest.tar.bz2

>
> > --
> > Catalin

Regards,
Michal

-- 
Michal K. K. Piotrowski
LTG - Linux Testers Group
(http://www.stardust.webpages.pl/ltg/)
