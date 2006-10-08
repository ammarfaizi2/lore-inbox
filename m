Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750879AbWJHHpx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750879AbWJHHpx (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Oct 2006 03:45:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750882AbWJHHpx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Oct 2006 03:45:53 -0400
Received: from nf-out-0910.google.com ([64.233.182.187]:11732 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1750873AbWJHHpw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Oct 2006 03:45:52 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        b=KkVQmhPO2qEOxztxMt58Oauf4a3qp9YBIT4UYq7AF45Niv+nx0GFUt98k5ubV8lsDHse4xaBAmeLHaDOMC3lHQuAWYjZ+2xV1tMc6MP8mfFfOYthSRrbJt2+ClOwZKA7PT52WloeilSulsPnoQ4kshtyQyQjozP9xjMQ+fM8TO0=
Message-ID: <84144f020610080045s6d2d1b06o6fc78bfb8fbf4d77@mail.gmail.com>
Date: Sun, 8 Oct 2006 10:45:50 +0300
From: "Pekka Enberg" <penberg@cs.helsinki.fi>
To: "Adrian Bunk" <bunk@stusta.de>
Subject: Re: 2.6.19-rc1: known regressions (v2)
Cc: "Trond Myklebust" <Trond.Myklebust@netapp.com>,
       linux-kernel@vger.kernel.org
In-Reply-To: <20061008063943.GB6755@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <EXSVLRB01xe0ymQ1WE900000265@exsvlrb01.hq.netapp.com>
	 <20061008045522.GG29474@stusta.de>
	 <1160283948.10192.3.camel@lade.trondhjem.org>
	 <20061008063943.GB6755@stusta.de>
X-Google-Sender-Auth: 37ba324e36ea64bd
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Trond,

On Sun, Oct 08, 2006 at 01:05:48AM -0400, Trond Myklebust wrote:
> > In any case, what the fuck gives you the right to appoint yourself judge
> > and jury over kernel regressions?

On 10/8/06, Adrian Bunk <bunk@stusta.de> wrote:
> I've given this right myself - everyone can always send any bug list he
> wants to linux-kernel.

I don't see what the problem here is. As stated in the bug report, a
patch signed off by you broke something in the kernel which is not yet
fixed in -git. Aside from calling people "guilty", what Adrian is
doing is a service to us all.

                                               Pekka
