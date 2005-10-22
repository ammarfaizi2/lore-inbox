Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932174AbVJVJl2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932174AbVJVJl2 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 22 Oct 2005 05:41:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932200AbVJVJl2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 22 Oct 2005 05:41:28 -0400
Received: from qproxy.gmail.com ([72.14.204.200]:30022 "EHLO qproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932174AbVJVJl2 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 22 Oct 2005 05:41:28 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=hCQczetEpWyK34pvIip6gaNmXd1x+pmVIJd0zTAjkTsELcQ6Y+ziKdYw0YC/RwOziQNf8PwfHYm4GmnabrAgPOD02R0QK3kv84OMBDg44JKG/CdIrq/+/y11X3myEsX/4bjFiTpzM7ttUUJJqEgXOPqF/UBGYCgLJMqhkFKzZKg=
Message-ID: <4d8e3fd30510220241i6c370dd1x512561cb6a1bc250@mail.gmail.com>
Date: Sat, 22 Oct 2005 11:41:25 +0200
From: Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com>
To: Con Kolivas <kernel@kolivas.org>
Subject: Re: [PATCH] mm - swap prefetch magnify
Cc: linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, ck list <ck@vds.kolivas.org>
In-Reply-To: <200510221147.59059.kernel@kolivas.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <200510221120.44473.kernel@kolivas.org>
	 <200510221147.59059.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/22/05, Con Kolivas <kernel@kolivas.org> wrote:
> On Sat, 22 Oct 2005 11:20, Con Kolivas wrote:
> > Testing has confirmed much larger prefetch values work well.
>
> Bah.. Sorry take this one instead. Just make sure that no matter how little
> ram we have prefetch is enabled.

Con,
would you be so kind to post more information about the test you've done ?

--
Paolo
Pleas click here: http://heracleum.altervista.org/top/site.php?vote=488
to support http://technologynews.altervista.org
