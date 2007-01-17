Return-Path: <linux-kernel-owner+w=401wt.eu-S1751605AbXAQHfk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751605AbXAQHfk (ORCPT <rfc822;w@1wt.eu>);
	Wed, 17 Jan 2007 02:35:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751693AbXAQHfk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Jan 2007 02:35:40 -0500
Received: from ug-out-1314.google.com ([66.249.92.174]:13660 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751605AbXAQHfj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Jan 2007 02:35:39 -0500
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=dG3sEO0BfbiVyHT42ZuoctmQeMQuKG+EBJ2zJg22XyDTpBIV9xaNS7aZD4Y/EC6oeOjlzr6p6bpnFzFKNwxlhuM3rxk+2FXrT4YDCtkucIrWi0tpG5KZXODgVV0Lzzqs6vdq//yJedb+7dP25QkXyXP1JFxh9ph/e8SF1+Rgst0=
Message-ID: <305c16960701162335x3a84bbe5y87ee8c0608b2eea6@mail.gmail.com>
Date: Wed, 17 Jan 2007 05:35:36 -0200
From: "Matheus Izvekov" <mizvekov@gmail.com>
To: "Luming Yu" <luming.yu@gmail.com>
Subject: Re: BUG: linux 2.6.19 unable to enable acpi
Cc: "Arjan van de Ven" <arjan@infradead.org>,
       "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
In-Reply-To: <3877989d0701162226p552b2d01q8438b0c561e5dd67@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <305c16960701162001j5ec23332hcd398cbe944916e1@mail.gmail.com>
	 <1169007288.3457.4.camel@laptopd505.fenrus.org>
	 <305c16960701162025o2f96eb25m79f58aede11821ec@mail.gmail.com>
	 <3877989d0701162226p552b2d01q8438b0c561e5dd67@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/17/07, Luming Yu <luming.yu@gmail.com> wrote:
> On 1/17/07, Matheus Izvekov <mizvekov@gmail.com> wrote:
> > It used to support power button events, dont know what else. Is there
> > anything I can do to check how good the acpi support is?
>
> Did you check BIOS setting? Is there any ACPI related menuitems?
No ACPI related menuitems, just APM ones, which are disabled.
> Does MS windows work?

Yes, but i dont have it anymore to check how acpi was working there.
But that is yes for sure, i could turn it off with the power button.

> Have you ever tried other kernel  i.e. 2.6.18, 2.6.17, 2.6.16..?
>

No, but ill try if it proves to be necessary.
