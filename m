Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261981AbULVNQS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261981AbULVNQS (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Dec 2004 08:16:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261985AbULVNQS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Dec 2004 08:16:18 -0500
Received: from [143.247.20.203] ([143.247.20.203]:8091 "EHLO
	cgx-mail.capitalgenomix.com") by vger.kernel.org with ESMTP
	id S261981AbULVNQO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Dec 2004 08:16:14 -0500
Message-ID: <41C9739A.7040408@capitalgenomix.com>
Date: Wed, 22 Dec 2004 08:16:10 -0500
From: "Fao, Sean" <sean.fao@capitalgenomix.com>
User-Agent: Mozilla Thunderbird 1.0RC1 (Windows/20041201)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Patrick McHardy <kaber@trash.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: what/where is ss tool ?
References: <00be01c4e819$aca09cd0$0e25fe0a@pysiak> <41C95B88.1070409@trash.net> <012f01c4e81f$f4bddbd0$0e25fe0a@pysiak> <20041222122758.GB6627@m.safari.iki.fi> <41C96F24.2050409@trash.net>
In-Reply-To: <41C96F24.2050409@trash.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Patrick McHardy wrote:

> Hi Dave,
>
> please apply this patch which gives users a pointer where
> to find the ss tool and adds an explanation about TCPDIAG
> and IPV6.
>
>+	  and have selected IPv6 as a module, you need to built this as a
>+	  module too.
>
Patrick, I caught one minor typo.  "you need to built this" should read, "you need to *build* this".

-- 
Sean E. Fao

Capital Genomix
9290 Gaither Road
Gaithersburg, MD.  20877

Phone: (301) 977-3224
Fax: (301) 977-3613
Web: http://www.capitalgenomix.com

