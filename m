Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932923AbWKQPKL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932923AbWKQPKL (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Nov 2006 10:10:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933646AbWKQPKL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Nov 2006 10:10:11 -0500
Received: from nz-out-0102.google.com ([64.233.162.196]:21948 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S932923AbWKQPKJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Nov 2006 10:10:09 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=fV9MnqrGYV7wejsJsp5qyxSy6HRwtIDuAR66fhhXpPqWBYOmjozy1T997pyt2qDbCFslZYTEW9J0VuNZvtxEZT6FmO4ky2tyooP+oq/yJ7u3Fj11HpcqOm6/AIjOzMyfq6RZTpchONUfXZhJu5vr7qGwOgdd2PUyNIGJbCDe/TI=
Message-ID: <6844644e0611170710j28e96e66yfb91fa5b97e2cb8f@mail.gmail.com>
Date: Fri, 17 Nov 2006 10:10:08 -0500
From: "Doug Reiland" <dreiland@gmail.com>
To: "ranjith kumar" <ranjit_kumar_b4u@yahoo.co.uk>
Subject: Re: diabling interrupts on pentium 4 processor
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20061116112312.43293.qmail@web27402.mail.ukl.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20061116112312.43293.qmail@web27402.mail.ukl.yahoo.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/16/06, ranjith kumar <ranjit_kumar_b4u@yahoo.co.uk> wrote:
> Hi,
>     How to disable interrupts on pentium 4 (or any
> i386)
>     machine?
>
>      I tried to include "cli" instruction in a kernel
> module. But got runtime error.

Are you doing this at the kernel level or application?
