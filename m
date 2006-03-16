Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932733AbWCPVme@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932733AbWCPVme (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Mar 2006 16:42:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932735AbWCPVme
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Mar 2006 16:42:34 -0500
Received: from zproxy.gmail.com ([64.233.162.196]:26013 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932733AbWCPVmd convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Mar 2006 16:42:33 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=NinWvqZersaOsNjIdH8CV8jlJXICrcL599fXpg+uwk7pc76/Z1yzH834i+f2emTfIbgQ3Xz20/A7Mp0p9xTXxhltoZjlQPUCE4B/peKcqVwCEcaf0lcEe5M7aG4wPzMDNtbQr+QbKPj+sRY69vOibHGRuDdyMpEMFpxuVKs1MDg=
Message-ID: <6bffcb0e0603161342n7346c203g@mail.gmail.com>
Date: Thu, 16 Mar 2006 22:42:32 +0100
From: "Michal Piotrowski" <michal.k.k.piotrowski@gmail.com>
To: "Ingo Molnar" <mingo@elte.hu>
Subject: Re: 2.6.16-rc6-rt7
Cc: linux-kernel@vger.kernel.org, "Thomas Gleixner" <tglx@linutronix.de>
In-Reply-To: <20060316095607.GA28571@elte.hu>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20060316095607.GA28571@elte.hu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 16/03/06, Ingo Molnar <mingo@elte.hu> wrote:
> i have released the 2.6.16-rc6-rt7 tree, which can be downloaded from
> the usual place:
>

My system hangs on that:
http://www.stardust.webpages.pl/files/rt/2.6.16-rc6-rt7/oops-v1.jpg
http://www.stardust.webpages.pl/files/rt/2.6.16-rc6-rt7/oops-v2.jpg
Both looks the same.

Here is config http://www.stardust.webpages.pl/files/rt/2.6.16-rc6-rt7/rt-config

Regards,
Michal

--
Michal K. K. Piotrowski
LTG - Linux Testers Group
(http://www.stardust.webpages.pl/ltg/wiki/)
