Return-Path: <linux-kernel-owner+w=401wt.eu-S1750857AbXAQG0m@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750857AbXAQG0m (ORCPT <rfc822;w@1wt.eu>);
	Wed, 17 Jan 2007 01:26:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750849AbXAQG0l
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Jan 2007 01:26:41 -0500
Received: from wx-out-0506.google.com ([66.249.82.228]:16154 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750816AbXAQG0l (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Jan 2007 01:26:41 -0500
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=lnEp9H9T3ZJubn3QsgrUCPimStob3WrAwrDevHGiT8KhFVDXjawoyFEZKLkxZAPPht1Gg1H8TlbqQ4cbxYK8yba5KXkvZmDYWoywdC4dqo2Ar+sEqMviuPXSf23E/khIMcj2K6MaYfMmmALHaMt94dRw0SaI76yPLGHJwoMQvbM=
Message-ID: <3877989d0701162226p552b2d01q8438b0c561e5dd67@mail.gmail.com>
Date: Wed, 17 Jan 2007 14:26:40 +0800
From: "Luming Yu" <luming.yu@gmail.com>
To: "Matheus Izvekov" <mizvekov@gmail.com>
Subject: Re: BUG: linux 2.6.19 unable to enable acpi
Cc: "Arjan van de Ven" <arjan@infradead.org>,
       "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
In-Reply-To: <305c16960701162025o2f96eb25m79f58aede11821ec@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <305c16960701162001j5ec23332hcd398cbe944916e1@mail.gmail.com>
	 <1169007288.3457.4.camel@laptopd505.fenrus.org>
	 <305c16960701162025o2f96eb25m79f58aede11821ec@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/17/07, Matheus Izvekov <mizvekov@gmail.com> wrote:
> On 1/17/07, Arjan van de Ven <arjan@infradead.org> wrote:
> > On Wed, 2007-01-17 at 02:01 -0200, Matheus Izvekov wrote:
> > > Just tried linux for the first time on this old machine, and i got
> > > this problem. dmesg below:
> >
> >
> > did this machine EVER support acpi ?
> >
> >
>
> It used to support power button events, dont know what else. Is there
> anything I can do to check how good the acpi support is?

Did you check BIOS setting? Is there any ACPI related menuitems?
Does MS windows work?
Have you ever tried other kernel  i.e. 2.6.18, 2.6.17, 2.6.16..?
