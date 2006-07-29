Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751394AbWG2TFT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751394AbWG2TFT (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 Jul 2006 15:05:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751414AbWG2TFT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 Jul 2006 15:05:19 -0400
Received: from ug-out-1314.google.com ([66.249.92.171]:40993 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1751394AbWG2TFS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 Jul 2006 15:05:18 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:sender:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        b=rFoqvCOiz4QB2r1k1elWayQFlOfm7jbLxwxLQ+X1DXB4t9mtl75L32yw0W6yjQEB2+KWetgg6raA6JfJLs/YGzP09yrRlNeCWNsV6qy1+IMFEfgP74kRDE6UdpTbJaOD801xO8/leg5SPWBFNBHsw6YNBOlo8opodqmTnFEOyCU=
Message-ID: <35fb2e590607291205m6fd44a40tf34d391ec6afc9a8@mail.gmail.com>
Date: Sat, 29 Jul 2006 20:05:16 +0100
From: "Jon Masters" <jonathan@jonmasters.org>
To: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MODULE_FIRMWARE for binary firmware(s)
In-Reply-To: <20060418234156.GA28346@apogee.jonmasters.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20060418234156.GA28346@apogee.jonmasters.org>
X-Google-Sender-Auth: 3531519759f0127a
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/19/06, Jon Masters <jonathan@jonmasters.org> wrote:

> The attached patch introduces MODULE_FIRMWARE as a mechanism for
> advertising that a particular firmware file is to be loaded - it will
> then show up via modinfo and could be used e.g. when packaging a kernel.

I (and several others who met at OLS) would really like for this to
get upstream. Can you sling that one line patch (will forward again)
into -mm please?

Jon.
