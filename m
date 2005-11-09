Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751393AbVKIL56@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751393AbVKIL56 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Nov 2005 06:57:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751395AbVKIL55
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Nov 2005 06:57:57 -0500
Received: from zproxy.gmail.com ([64.233.162.196]:51315 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751393AbVKIL54 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Nov 2005 06:57:56 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=aUHAKVrjs+oGeKNBsoXPMUr/ky4WNkacyzGBzK0gHQcfyh1eKdzwITv1Vr5u3wSoEmauHaLEBLMrGsY/HDX56D5m6F+TkSndyZUzlES6ZUW0Kx0DMr+Oh4wGpwhJwEMB7Y1Tjng5bOzOkcr+HVXjq70Q3re336zQk3jD/F19mGo=
Message-ID: <1a56ea390511090357m5ff9ababsaff340c757b8ab42@mail.gmail.com>
Date: Wed, 9 Nov 2005 11:57:56 +0000
From: DaMouse <damouse@gmail.com>
To: rick@vanrein.org, linux-kernel@vger.kernel.org
Subject: Re: BadRAM for 2.6.14
In-Reply-To: <20051109095343.GA17048@roonstrasse.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20051109095343.GA17048@roonstrasse.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/9/05, Max Kellermann <max@duempel.org> wrote:
> Hi Rick,
>
> I have ported your BadRAM patch to the new kernel 2.6.14.  There were
> a few tiny formal corrections due to patch conflicts; besides that, I
> did not change anything.
>
> To linux-kernel: is there a reason why this patch was never added to
> Linus' tree?  It helped me save money more than once.
>
> Max
>
>
>

Hey,

Didn't happen to make a x86_64 one did you? Really good job, I love
this patch so much and I think I'll look into a 64bit variant when I'm
bored in french or something.

-DaMouse
