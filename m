Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932090AbWJ1Sxc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932090AbWJ1Sxc (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Oct 2006 14:53:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932088AbWJ1Sxc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Oct 2006 14:53:32 -0400
Received: from nf-out-0910.google.com ([64.233.182.187]:20312 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S932087AbWJ1Sxb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Oct 2006 14:53:31 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        b=QMre3aB2+uh06MIp9anEgYhPuLC0YSnGHcGYS7jQOrEOEYA3ryy97oGBSC2hYXf83PgTHUMA8Is8iWoL17R0ZlUVnJGIVUUlPdrVH2viKBD2ZGKOaXjmiiXx0gfOWoMXqzwlMna73c+d4u2EJOdkipmFM493QuVIrX3PLWKwem0=
Message-ID: <86802c440610281153p71488109t97e34f6ea61628c@mail.gmail.com>
Date: Sat, 28 Oct 2006 11:53:29 -0700
From: "Yinghai Lu" <yinghai.lu@amd.com>
To: "Andi Kleen" <ak@muc.de>
Subject: Re: [PATCH] x86_64 irq: reuse vector for __assign_irq_vector
Cc: "Eric W. Biederman" <ebiederm@xmission.com>,
       "Andrew Morton" <akpm@osdl.org>, "Muli Ben-Yehuda" <muli@il.ibm.com>,
       "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
       "Adrian Bunk" <bunk@stusta.de>
In-Reply-To: <20061028174622.GB92790@muc.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <86802c440610232115r76d98803o4293cdafce1fd95c@mail.gmail.com>
	 <20061028174622.GB92790@muc.de>
X-Google-Sender-Auth: 6ce5f28e0245c194
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 28 Oct 2006 19:46:22 +0200, Andi Kleen <ak@muc.de> wrote:
> On Mon, Oct 23, 2006 at 09:15:31PM -0700, yhlu wrote:

> Hmm, i'm not sure I got that. Which was patch was it exactly


Eric's online cpus patch is already in the maintream.

Please use the diff in

http://lkml.org/lkml/2006/10/26/38

Thanks

YH
