Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261156AbVD0IBl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261156AbVD0IBl (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Apr 2005 04:01:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261179AbVD0IBl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Apr 2005 04:01:41 -0400
Received: from wproxy.gmail.com ([64.233.184.205]:5648 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261156AbVD0IBj convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Apr 2005 04:01:39 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=GLT8rX76dN2RDlSW9zqcwRbc5vxqm8PdMjudCmtQyLMboxzVzUm21fxZNntgo1JV+otr1W2kKpuWs53GcKsYnFL97xiK7eiHP/v3xk+HaDnsdlR4JIidMtxas1+1B8bRRzFFIdIkBhzY4/SK2wColny/T/ojneSHhNPqsSCV92Q=
Message-ID: <84144f0205042701017097782c@mail.gmail.com>
Date: Wed, 27 Apr 2005 11:01:28 +0300
From: Pekka Enberg <penberg@gmail.com>
Reply-To: Pekka Enberg <penberg@gmail.com>
To: "David N. Welton" <davidw@dedasys.com>
Subject: Re: rootdelay
Cc: dsd@gentoo.org, linux-kernel@vger.kernel.org
In-Reply-To: <87k6mp9uv8.fsf@dedasys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <87wtrphuvj.fsf@dedasys.com>
	 <84144f020504260311260fa8c5@mail.gmail.com>
	 <87k6mp9uv8.fsf@dedasys.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi David,

On 26 Apr 2005 21:54:35 +0200, David N. Welton <davidw@dedasys.com> wrote:
> Oh, I most certainly will polish the code as much as possible should
> it prove of interest, but I think what needs vetting is the idea
> itself, which I described clearly in english in a subsequent email.
> If the idea itself stinks, I'm happy to drop it before spending time
> playing around with indentation and other niceties.

But see, that's the problem. You think _other people_ should spend
time reviewing your work first so _you_ don't have to waste time.
Unfortunately, it looks to me like no one is willing to spend their
time reviewing a patch which (a) does not follow
Documentation/CodingStyle and (b) is not submitted as per
Documentation/SubmittingPatches.

I mean, how much work is it to run you code through scripts/Lindent
and drop those awful function banner comments and resend the patch?-)

                                 Pekka
