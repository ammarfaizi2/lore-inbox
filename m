Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263666AbUDFJAd (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Apr 2004 05:00:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263669AbUDFJAd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Apr 2004 05:00:33 -0400
Received: from test.estpak.ee ([194.126.115.47]:41982 "EHLO arena.estpak.ee")
	by vger.kernel.org with ESMTP id S263667AbUDFJAb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Apr 2004 05:00:31 -0400
From: Hasso Tepper <hasso@estpak.ee>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Subject: Re: Kernel panic in 2.4.25
Date: Tue, 6 Apr 2004 12:00:13 +0300
User-Agent: KMail/1.6.2
Cc: Matt Brown <matt@mattb.net.nz>, kernel@linuxace.com,
       linux-kernel@vger.kernel.org, linux-net@vger.kernel.org,
       dlstevens@ibm.com, davem@redhat.com
References: <1081129354.1611.44.camel@argon.shr.crc.net.nz> <20040405142202.GB12470@logos.cnet>
In-Reply-To: <20040405142202.GB12470@logos.cnet>
MIME-Version: 1.0
Content-Disposition: inline
Organization: Elion Enterprises Ltd.
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200404061200.13939.hasso@estpak.ee>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marcelo Tosatti wrote:
> This oops should be fixed by
>
> http://linux.bkbits.net:8080/linux-2.4/patch@1.1342?nav=index.html|
>ChangeSet@-7d|cset@1.1342
>
> Which will be part of 2.4.26-rc2. Please try it.

Seems so. Thanks.

-- 
Hasso Tepper
Elion Enterprises Ltd.
WAN administrator
