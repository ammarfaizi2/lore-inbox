Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161012AbWIGAKp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161012AbWIGAKp (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Sep 2006 20:10:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161013AbWIGAKp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Sep 2006 20:10:45 -0400
Received: from wx-out-0506.google.com ([66.249.82.234]:29366 "EHLO
	wx-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1161012AbWIGAKo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Sep 2006 20:10:44 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Oik4ZiOo8407EGAkRRzoM+hY8g8KzIC7Enwf8+OebH53+PLmi/daitfyzlyfxfZQnCfWfLvdukdy8BgkcmHRfsSX8Cas2YykFKaMNFjTrXu/7djwvAL4Wu5zRkt0LcdsKz8LjIhcrz+P4D1oF+G3YKgWIQ+Uyn6uv2BOuOYN018=
Message-ID: <6bffcb0e0609061710t3519e42dl6138cadd5ff0d3fb@mail.gmail.com>
Date: Thu, 7 Sep 2006 02:10:43 +0200
From: "Michal Piotrowski" <michal.k.k.piotrowski@gmail.com>
To: "Catalin Marinas" <catalin.marinas@gmail.com>
Subject: Re: [PATCH 2.6.18-rc6 00/10] Kernel memory leak detector 0.10
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20060906223536.21550.55411.stgit@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20060906223536.21550.55411.stgit@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Catalin,

On 07/09/06, Catalin Marinas <catalin.marinas@gmail.com> wrote:
> This is a new version (0.10) of the kernel memory leak detector. See
> the Documentation/kmemleak.txt file for a more detailed
> description. The patches are downloadable from (the whole patch or the
> broken-out series):
>
> http://homepage.ntlworld.com/cmarinas/kmemleak/patch-2.6.18-rc6-kmemleak-0.10.bz2

I get a kernel panic
http://www.stardust.webpages.pl/files/o_bugs/kmemleak-0.10/panic.jpg

http://www.stardust.webpages.pl/files/o_bugs/kmemleak-0.10/kml-config

Regards,
Michal

-- 
Michal K. K. Piotrowski
LTG - Linux Testers Group
(http://www.stardust.webpages.pl/ltg/)
