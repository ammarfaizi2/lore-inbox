Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932233AbVKFAQg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932233AbVKFAQg (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Nov 2005 19:16:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932235AbVKFAQg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Nov 2005 19:16:36 -0500
Received: from xproxy.gmail.com ([66.249.82.193]:48175 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932233AbVKFAQg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Nov 2005 19:16:36 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:user-agent:x-accept-language:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding:from;
        b=dw8QXm9qYM3sHNKDinPv6WJprCgl+qmw8Ks8nuJ4srVilyPLY0W6JxfJ7Xm8oC9re1x95S4wGHi/fkCV4huW8nLEN0t24jTsMAUJzEzrQwjjZvfnDI34GEFordkTl5HsTavLW7+vPycVEd4RMS5nJuN/2gzK8UNrMLM1PEsbTm8=
Message-ID: <436D4B5A.2040303@pol.net>
Date: Sun, 06 Nov 2005 08:16:26 +0800
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050715)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Arnd Bergmann <arnd@arndb.de>
CC: linux-kernel@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
       linux-fbdev-devel@lists.sourceforge.net
Subject: Re: [PATCH 11/25] framebuffer: move ioctl32 code to fbmem.c
References: <20051105162650.620266000@b551138y.boeblingen.de.ibm.com> <20051105162714.961205000@b551138y.boeblingen.de.ibm.com>
In-Reply-To: <20051105162714.961205000@b551138y.boeblingen.de.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
From: "Antonino A. Daplas" <adaplas@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arnd Bergmann wrote:
> The frame buffer layer already had some code dealing with
> compat ioctls, this patch moves over the remaining code
> from fs/compat_ioctl.c

This is fine with me.

Tony
