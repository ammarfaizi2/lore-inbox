Return-Path: <linux-kernel-owner+akpm=40zip.com.au-S1751076AbWFEVwk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751076AbWFEVwk (ORCPT <rfc822;akpm@zip.com.au>);
	Mon, 5 Jun 2006 17:52:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751092AbWFEVwk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jun 2006 17:52:40 -0400
Received: from wr-out-0506.google.com ([64.233.184.229]:42118 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1751076AbWFEVwj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jun 2006 17:52:39 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=CmVBU1rJpa7nT3YB+hSuP9+Jjp/sq6fkdm882wCWRygSZkQd1x9WY/v6EK2Uw7i/aZevRsyepd4EkHxxi8wiyF3sb1FPX9/BCL2kABk3jQsjOr9QiWSk1g5xUeT4nx0937OzTLsUzdPcLhrX4UnwzbI6L5/nj7a+VGIEDPIRNwY=
Message-ID: <6bffcb0e0606051452p26f20c8r57f2c782de691210@mail.gmail.com>
Date: Mon, 5 Jun 2006 23:52:38 +0200
From: "Michal Piotrowski" <michal.k.k.piotrowski@gmail.com>
To: "Catalin Marinas" <catalin.marinas@gmail.com>
Subject: Re: [PATCH 2.6.17-rc5 0/8] Kernel memory leak detector 0.5
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20060604215636.16277.15454.stgit@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20060604215636.16277.15454.stgit@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/06/06, Catalin Marinas <catalin.marinas@gmail.com> wrote:
> This is a new version (0.5) of the kernel memory leak detector. It is
> mainly a bug-fix release after testing it with a wider range of kernel
> modules. See the Documentation/kmemleak.txt file for a more detailed
> description. The patches are downloadable from (the bundled patch or
> the series):
>
> http://homepage.ntlworld.com/cmarinas/kmemleak/patch-2.6.17-rc5-kmemleak-0.5.bz2
> http://homepage.ntlworld.com/cmarinas/kmemleak/patches-kmemleak-0.5.tar.bz2
>

System hangs while starting udev.

Here is config
http://www.stardust.webpages.pl/files/kml/kml-config

Here is "Kernel Bug : The Movie 2" ;)
http://www.stardust.webpages.pl/files/crap/kbtm2.avi

$ gcc-3.4 --version
gcc-3.4 (GCC) 3.4.6

Regards,
Michal

-- 
Michal K. K. Piotrowski
LTG - Linux Testers Group
(http://www.stardust.webpages.pl/ltg/wiki/)
