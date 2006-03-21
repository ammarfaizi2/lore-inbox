Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423190AbWCUSgi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423190AbWCUSgi (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Mar 2006 13:36:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423249AbWCUSgh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Mar 2006 13:36:37 -0500
Received: from wproxy.gmail.com ([64.233.184.192]:55681 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1423195AbWCUSge convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Mar 2006 13:36:34 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=HMifhNC7LMotSODOPN3zCxW9McJz+TEFqecUK8obxWLCBtfxuvt7haUu98QxBQB/pLhYJtdudIoenWJu3ZDWdMtcLp89jb9BxoRreHZEfuO1y6TV1wU1Km8NczFBDcfWFf+mLeRYU6vRJmTyQt1L5IeKE01Jr91K1fKBJvN+zAU=
Message-ID: <6bffcb0e0603211036i7cce3776p@mail.gmail.com>
Date: Tue, 21 Mar 2006 19:36:32 +0100
From: "Michal Piotrowski" <michal.k.k.piotrowski@gmail.com>
To: "Ingo Molnar" <mingo@elte.hu>
Subject: Re: 2.6.16-rt1
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20060321170149.GA27290@elte.hu>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20060320085137.GA29554@elte.hu>
	 <200603211430.29466.Serge.Noiraud@bull.net>
	 <20060321170149.GA27290@elte.hu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ingo,

On 21/03/06, Ingo Molnar <mingo@elte.hu> wrote:
>
> could you check -rt2?
>

Here is first oops http://www.stardust.webpages.pl/files/rt/2.6.16-rt2/b1.jpg
Here is second oops http://www.stardust.webpages.pl/files/rt/2.6.16-rt2/b2.jpg

Here is config http://www.stardust.webpages.pl/files/rt/2.6.16-rt2/rt-config

I can't boot that kernel, 2.6.16-rt1 was fine.

Regards,
Michal

--
Michal K. K. Piotrowski
LTG - Linux Testers Group
(http://www.stardust.webpages.pl/ltg/wiki/)
