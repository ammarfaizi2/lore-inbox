Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161109AbVIBXR3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161109AbVIBXR3 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Sep 2005 19:17:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161123AbVIBXR3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Sep 2005 19:17:29 -0400
Received: from wproxy.gmail.com ([64.233.184.205]:63135 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1161109AbVIBXR3 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Sep 2005 19:17:29 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Oz46xucjja4dY1nZsNK4f6WDBjt2EA4LlpCxI1nDZoZv9eT/ngJ3W1BApFwqXUxs9rldXZXoOaF6zNeSiMFMJH5VTs4fwnwgA//VS9GXWKEHmBiX1hkBdhcZqRKE1LqO1DnQpDfVAu96Q86h4ia72PbKdeTaUGPtDd4+eyfNAqQ=
Message-ID: <e646715805090216174859f95d@mail.gmail.com>
Date: Fri, 2 Sep 2005 18:17:24 -0500
From: Sabuj Pattanayek <sabujp@gmail.com>
Reply-To: sabujp@gmail.com
To: linux-kernel@vger.kernel.org
Subject: Re: Inconsistent kallsyms data error near the end of make in the linux kernel-2.6.13
In-Reply-To: <1125619916.431798cced77b@webmail.grupopie.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <e6467158050901170059d5c53c@mail.gmail.com>
	 <1125619916.431798cced77b@webmail.grupopie.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks, that worked for this system.

On 9/1/05, pmarques@grupopie.com <pmarques@grupopie.com> wrote:
> Quoting Sabuj Pattanayek <sabujp@gmail.com>:
> 
> > Hi all,
> 
> Hi, Sabuj
> 
> > I'm posting a bug as directed by REPORTING-BUGS in the kernel sources.
> >
> > PROBLEM: Inconsistent kallsyms data error near the end of make in the linux
> > kernel-2.6.13 .
> 
> This is probably a known problem.
> 
> Please check this thread:
> 
> http://lkml.org/lkml/2005/8/31/129
> 
> and use the patch I posted there.
> 
> I hope this helps,
> 
> --
> Paulo Marques
