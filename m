Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750933AbWH1OTO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750933AbWH1OTO (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Aug 2006 10:19:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750940AbWH1OTN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Aug 2006 10:19:13 -0400
Received: from wr-out-0506.google.com ([64.233.184.231]:18466 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1750932AbWH1OTM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Aug 2006 10:19:12 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        b=WjsfQfLxtee/MbBeUHVehfvTzHA+M1umNs2EGoThVPrFESh8q+AyoceGtFTWoTy4xJL8bgd891JqOxos9/LRY/MYcrQy6rzbTx2a+JKt4f21LTaEgkOnJbXGuI+SJ9mCeftIxX9pkHOhmX5ylsEWbS2ExyceF+El8aRzpc4e2lA=
Message-ID: <39e6f6c70608280718p4830dc96u89b80c45a4ac5ffc@mail.gmail.com>
Date: Mon, 28 Aug 2006 11:18:57 -0300
From: "Arnaldo Carvalho de Melo" <acme@ghostprotocols.net>
To: "gerrit@erg.abdn.ac.uk" <gerrit@erg.abdn.ac.uk>
Subject: Re: [RFC][PATCH 0/3] net: a lighter UDP-Lite (RFC 3828)
Cc: davem@davemloft.net, jmorris@namei.org, alan@lxorguk.ukuu.org.uk,
       kuznet@ms2.inr.ac.ru, pekkas@netcore.fi, kaber@coreworks.de,
       yoshfuji@linux-ipv6.org, netdev@vger.kernel.org,
       linux-kernel@vger.kernel.org
In-Reply-To: <200608281513.49959@strip-the-willow>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <200608231150.37895@strip-the-willow>
	 <200608281159.21583@strip-the-willow>
	 <39e6f6c70608280548p5ba363d7o18cfd3bdb2f9e894@mail.gmail.com>
	 <200608281513.49959@strip-the-willow>
X-Google-Sender-Auth: 0805612cc2a72b95
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/28/06, gerrit@erg.abdn.ac.uk <gerrit@erg.abdn.ac.uk> wrote:
> Quoting Arnaldo Carvalho de Melo:
> |  Avoid these changes to reduce patch file size, please
>
> I apologize for the bad patch format - I am revising the entire
> patch to improve readability and will resend.

 No need for apologies and thanks for taking my suggestions into account.

- Arnaldo
