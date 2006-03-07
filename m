Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932312AbWCGUZe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932312AbWCGUZe (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Mar 2006 15:25:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932347AbWCGUZe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Mar 2006 15:25:34 -0500
Received: from wproxy.gmail.com ([64.233.184.196]:23596 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932312AbWCGUZd convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Mar 2006 15:25:33 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=S1zHNHcnifwDcMTkDfkHuSvjJ5LguxWKjpodmCx1BGcL5tonI7OSkgcvmsRiDSmmguQwavpJGMp+0liP1CfRTjBC3TCe4rkcCkiHHx9VRmBvt2cULlt2lhHtYpJrBr+CwxMEXCY2r9npQa4vlebdkuOYNG0oMoh/1dZizKmwjNU=
Message-ID: <9a8748490603071225mae1861ap3d1ef9e7e0040875@mail.gmail.com>
Date: Tue, 7 Mar 2006 21:25:32 +0100
From: "Jesper Juhl" <jesper.juhl@gmail.com>
To: "Ivancso Krisztian" <ivan@swi.co.hu>
Subject: Re: PROBLEM: random freeze
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <9a8748490603071223k128ca34lc0fd9c416e4bca36@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <440DCAF1.2020102@swi.co.hu>
	 <9a8748490603071223k128ca34lc0fd9c416e4bca36@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/7/06, Jesper Juhl <jesper.juhl@gmail.com> wrote:
> On 3/7/06, Ivancso Krisztian <ivan@swi.co.hu> wrote:
> > Hi!
> >
> > I have an IBM xSeries 235, which randomly freeze. I tried many kernels.
> >
> [snip]
>
> If this is reproducible could you please try 2.6.16-rc5-git10 and/or
> 2.6.16-rc5-mm2 and send the Oops report from those kernels please?
>

Sorry, make that 2.6.16-rc5-git10 and/or 2.6.16-rc5-mm3.

--
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
