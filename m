Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752744AbWKBIvM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752744AbWKBIvM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Nov 2006 03:51:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752746AbWKBIvM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Nov 2006 03:51:12 -0500
Received: from nf-out-0910.google.com ([64.233.182.184]:32517 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1752744AbWKBIvK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Nov 2006 03:51:10 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:reply-to:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding:from;
        b=A4RTL8b3dScfoS42YMNEUqZ47hPxGkjYy7TxRwo0slrJ+w4Scm+Himiqhuya9CBvdGD/6w2TQXh46HuGcocBTngvnDVXvkCDeE8zcKqGkn1S69nBoba52vxy2wkci0MMTeWgZl/d+JwcpiQ8zapnv2iSDOo3/d0oo5CWBbs45qs=
Message-ID: <4549B19C.70304@innova-card.com>
Date: Thu, 02 Nov 2006 09:51:40 +0100
Reply-To: Franck <vagabon.xyz@gmail.com>
User-Agent: Thunderbird 1.5.0.4 (X11/20060614)
MIME-Version: 1.0
To: Miguel Ojeda Sandonis <maxextreme@gmail.com>
CC: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH update6] drivers: add LCD support
References: <20061101014057.454c4f43.maxextreme@gmail.com>
In-Reply-To: <20061101014057.454c4f43.maxextreme@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
From: Franck Bui-Huu <vagabon.xyz@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

Miguel Ojeda Sandonis wrote:
> Andrew, here it is the coding style fixes. Thanks you.
> 
> I think the driver is getting ready for freeze until
> 2.6.20-rc1 (if anyone sees something wrong), so I will
> try to send just minor fixes like this.

:)

Again, any thoughts on cache aliasing ?

Thanks
		Franck

