Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751557AbWFKCYy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751557AbWFKCYy (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Jun 2006 22:24:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751558AbWFKCYy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Jun 2006 22:24:54 -0400
Received: from nz-out-0102.google.com ([64.233.162.203]:4973 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1750900AbWFKCYx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Jun 2006 22:24:53 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=ng1Sq1Ibt1sMlJcEiRcKkv1RHxC3ZOCQ/EF1JGGe8vxvZJpW9UWoC3POL2P3OUmEx7sPyzrmgsMl6/CtMTi0AA1AzXSwbCt4cYLrVEsXN6H3yGkpbZPdQKRiBiVmKJKw3IasAzVcOBZisKhOyqvU6EybsIFKCAY5HO7sP8yiwUk=
Message-ID: <9f7850090606101924r32947e69vb6a34fe905227ff4@mail.gmail.com>
Date: Sat, 10 Jun 2006 19:24:53 -0700
From: "marty fouts" <mf.danger@gmail.com>
To: "David Woodhouse" <dwmw2@infradead.org>
Subject: Re: VGER does gradual SPF activation (FAQ matter)
Cc: "Matti Aarnio" <matti.aarnio@zmailer.org>, linux-kernel@vger.kernel.org
In-Reply-To: <1149980791.18635.197.camel@shinybook.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20060610222734.GZ27502@mea-ext.zmailer.org>
	 <1149980791.18635.197.camel@shinybook.infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/10/06, David Woodhouse <dwmw2@infradead.org> wrote:
> On Sun, 2006-06-11 at 01:27 +0300, Matti Aarnio wrote:
> > Now that there is even an RFC published about SPF...
>
> Please, don't do this. SPF makes assumptions about email which are just
> not true; it rejects perfectly valid mail.
>
> http://david.woodhou.se/why-not-spf.html
>
> --
> dwmw2

I agree.

Further, while there is an RFC for SPF, it is an RFC for an
experimental protocol. In addition to what David points out in his web
site, SPF is controversial, and is in competition with other
approaches.  (See RFC 4408.)

It's not widely deployed. It doesn't work. It'll break standard-abiding email.

Do you really want that?
