Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261631AbVCRPHE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261631AbVCRPHE (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Mar 2005 10:07:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261628AbVCRPHD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Mar 2005 10:07:03 -0500
Received: from rproxy.gmail.com ([64.233.170.198]:37245 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261629AbVCRPG6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Mar 2005 10:06:58 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=MydN7NHrS713REEcfmNC0J66hWXLiXZWCcHXJsyFoQllD0liglJyqRGt/laGyUCqqONGjXaM1myIPgtyAFjnA1bHxUnz09TkPmy0ryeNYLsOPxQemfGkjHVqg4ycZ43kZTFjWVC/RFNcKLH86rUlaPxPbMFCj2VTAJTzzJsEg/s=
Message-ID: <4f6c1bdf05031807063460dc7b@mail.gmail.com>
Date: Fri, 18 Mar 2005 20:36:58 +0530
From: Hong Kong Phoey <hongkongphoey@gmail.com>
Reply-To: Hong Kong Phoey <hongkongphoey@gmail.com>
To: Imanpreet Arora <imanpreet@gmail.com>
Subject: Re: Question on Scheduler activations
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <c26b9592050318060863830434@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
References: <c26b9592050318060863830434@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

RTFM


On Fri, 18 Mar 2005 19:38:45 +0530, Imanpreet Arora <imanpreet@gmail.com> wrote:
> Hello,
> 
>        I came across
> 
>                http://people.redhat.com/drepper/glibcthreads.html
> 
>        It seems to arouse a bit of confusion. _FIRST_ it says that scheduler
> activations are BAD. Then it delves on the possible implementation of
> Scheduler activations in Linux. Though I know that scheduler
> activations are not part of the present kernel. Could anyone provide
> BOTH the short and long answer to
> 
> a)      If they were ever implemented?
> b)      Reasons for rejection?
> 
> TIA
> 
> --
> 
> Imanpreet Singh Arora
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>
