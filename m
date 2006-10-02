Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965425AbWJBVkv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965425AbWJBVkv (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Oct 2006 17:40:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965430AbWJBVku
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Oct 2006 17:40:50 -0400
Received: from py-out-1112.google.com ([64.233.166.176]:844 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S965425AbWJBVkm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Oct 2006 17:40:42 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Bzh7DO3rw/PGWq1rPPozkQpPDKYYZiiaseocz1azRnVOTcxSISYyz6sNroLe8q5ao04eNKjJCq7xuRwOgroDitIBOfy0IluWKDQBx3zEag5Ga2IVK6mdjf6HjTPsZ7nBibO22Kgi9xhcskw0Q7uvZjbnvDlvKk782qthdlu0nTM=
Message-ID: <653402b90610021440h2e416394r55227ce5e7eb6171@mail.gmail.com>
Date: Mon, 2 Oct 2006 23:40:41 +0200
From: "Miguel Ojeda" <maxextreme@gmail.com>
To: andrew.j.wade@gmail.com
Subject: Re: [PATCH 2.6.18 V7] drivers: add lcd display support
Cc: akpm@osdl.org, "Stefan Richter" <stefanr@s5r6.in-berlin.de>,
       "Randy Dunlap" <rdunlap@xenotime.net>, linux-kernel@vger.kernel.org
In-Reply-To: <200610021449.08640.ajwade@cpe001346162bf9-cm0011ae8cd564.cpe.net.cable.rogers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20060930232445.59e8adf6.maxextreme@gmail.com>
	 <653402b90610010553p23819d2bsd7a07fabaee7ecf3@mail.gmail.com>
	 <200610021449.08640.ajwade@cpe001346162bf9-cm0011ae8cd564.cpe.net.cable.rogers.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/2/06, Andrew James Wade <andrew.j.wade@gmail.com> wrote:
> On Sunday 01 October 2006 08:53, Miguel Ojeda wrote:
> > Sure it is wrong, the point is what is the best to understading. "LCD
> > display" seems better to me than just "LC display".
>
> To me too. Acronyms tend to be treated as opaque tokens in English:
> their expansions tend not be be well known and don't really interact
> with their usage. "LCD display" is fine, and is clearer than both
> "LCD" or "liquid crystal display". (Some users won't know that a
> "liquid crystal display" is what they know as an "LCD display").
>
> Andrew Wade
>

I agree. As I said, in other languages is also common to use "LCD" as
a adjective, not as a noun.

Andrew, can you tell me how should I name it? So I will be able to
change it (if apply) and send the V8 patch.

I wish V8 will be the final patch...
