Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751040AbWJBStS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751040AbWJBStS (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Oct 2006 14:49:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751053AbWJBStS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Oct 2006 14:49:18 -0400
Received: from nz-out-0102.google.com ([64.233.162.197]:6268 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1751036AbWJBStR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Oct 2006 14:49:17 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:reply-to:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id:from;
        b=UB0D3Jh4rN//p7WiL4DacaduByI2uhQQl8G8XGwdpo/jbYKPGUicFKhXuhbWSl+pk0RYoJk061nswFmr4AFZNz4DcqkAhJiL2+vpRQKVQN0C1W9F2vrww2xIRGP1j4Id+G1+/ilLPRl5eBrzl/zu1z+ASypv5hP6qErx+Ku7Lkw=
Reply-To: andrew.j.wade@gmail.com
To: "Miguel Ojeda" <maxextreme@gmail.com>
Subject: Re: [PATCH 2.6.18 V7] drivers: add lcd display support
Date: Mon, 2 Oct 2006 14:49:07 -0400
User-Agent: KMail/1.9.1
Cc: akpm@osdl.org, "Stefan Richter" <stefanr@s5r6.in-berlin.de>,
       "Randy Dunlap" <rdunlap@xenotime.net>, linux-kernel@vger.kernel.org
References: <20060930232445.59e8adf6.maxextreme@gmail.com> <653402b90610010553p23819d2bsd7a07fabaee7ecf3@mail.gmail.com>
In-Reply-To: <653402b90610010553p23819d2bsd7a07fabaee7ecf3@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200610021449.08640.ajwade@cpe001346162bf9-cm0011ae8cd564.cpe.net.cable.rogers.com>
From: Andrew James Wade <andrew.j.wade@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 01 October 2006 08:53, Miguel Ojeda wrote:
> Sure it is wrong, the point is what is the best to understading. "LCD
> display" seems better to me than just "LC display".

To me too. Acronyms tend to be treated as opaque tokens in English:
their expansions tend not be be well known and don't really interact
with their usage. "LCD display" is fine, and is clearer than both
"LCD" or "liquid crystal display". (Some users won't know that a
"liquid crystal display" is what they know as an "LCD display").

Andrew Wade
