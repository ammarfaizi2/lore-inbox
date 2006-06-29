Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932811AbWF2Vlt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932811AbWF2Vlt (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jun 2006 17:41:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932809AbWF2Vls
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jun 2006 17:41:48 -0400
Received: from py-out-1112.google.com ([64.233.166.179]:5254 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S932805AbWF2Vlo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jun 2006 17:41:44 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=t0yXwUdFqSzZoMwdV7IVmw8ceSO8WOGLPWmUzEyVimkIMXFKIkHDJ2UjxQBUuvV2Z4dSvweZWk+qZwMtwhVVj+ZEzKFiIp8k9wOv0vv3orcLqJsc6E5kiSVveN5qkZHrb42cgXXPbyDU4CxrtrqbeYTro7Vs3kS3pvFhNHGeVZU=
Message-ID: <6bffcb0e0606291441u4f90e4b2ieb0cdf38fc29d486@mail.gmail.com>
Date: Thu, 29 Jun 2006 23:41:43 +0200
From: "Michal Piotrowski" <michal.k.k.piotrowski@gmail.com>
To: "Andrew Morton" <akpm@osdl.org>
Subject: Re: 2.6.17-mm4
Cc: davej@redhat.com, linux-kernel@vger.kernel.org, netdev@vger.kernel.org
In-Reply-To: <20060629135826.20328067.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20060629013643.4b47e8bd.akpm@osdl.org>
	 <6bffcb0e0606291339s69a16bc5ie108c0b8d4e29ed6@mail.gmail.com>
	 <20060629204330.GC13619@redhat.com>
	 <6bffcb0e0606291346s64530db4g1c9c33da9cf34e73@mail.gmail.com>
	 <20060629135826.20328067.akpm@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 29/06/06, Andrew Morton <akpm@osdl.org> wrote:
[snip]
> OK.  Perhaps try setting 8k stacks?
>
> Disable lockdep?
>

I don't see that now. I will try to reproduce this with a previous
config + Ingo's "Ignore loglevel on printks" patch.

Regards,
Michal

-- 
Michal K. K. Piotrowski
LTG - Linux Testers Group
(http://www.stardust.webpages.pl/ltg/wiki/)
