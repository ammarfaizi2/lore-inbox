Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752068AbWIHDZi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752068AbWIHDZi (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Sep 2006 23:25:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752067AbWIHDZi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Sep 2006 23:25:38 -0400
Received: from py-out-1112.google.com ([64.233.166.176]:48476 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1752065AbWIHDZg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Sep 2006 23:25:36 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Qa7sI4Ls7hYXMkBYEwOkiGY4NDrdnoEbcG4fCG/zaEBj/aDkLA/Jdjusp4UjpCJNc6IbDowcQatihCZ1BnDee0hJ1b21Bjp+UdnL9yitEk1dkqn7UQ257Ndv3d5mp6/KSHMp3BTcI94zLTzkTA/JWvgMte78NAaXd4NYs4Si5F8=
Message-ID: <a44ae5cd0609072025i136f9a04ib01ba9c01f332b29@mail.gmail.com>
Date: Thu, 7 Sep 2006 20:25:35 -0700
From: "Miles Lane" <miles.lane@gmail.com>
To: LKML <linux-kernel@vger.kernel.org>, linux-acpi@vger.kernel.org,
       "Brown, Len" <len.brown@intel.com>, "Andrew Morton" <akpm@osdl.org>
Subject: Re: 2.6.18-rc4-mm3 -- ACPI Error (utglobal-0125): Unknown exception code: 0xFFFFFFEA [20060707]
In-Reply-To: <a44ae5cd0608270927w62216a00i70966f1e8a190878@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <a44ae5cd0608262356j29c0234cl198fb207bcad383d@mail.gmail.com>
	 <20060827001437.ec4f7a7a.akpm@osdl.org>
	 <17649.47572.627874.371564@stoffel.org> <44F1C336.50304@free.fr>
	 <a44ae5cd0608270927w62216a00i70966f1e8a190878@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ping...

I just reproduced this ACPI error with 2.6.18-rc5-mm1 + all hotfixes +
a crypto patch from Herbert + two nodemgr patched from Stefan + a max
trace depth patch from Ingo.

Any additional debug information needed?  Any progress?

Thanks,
         Miles
