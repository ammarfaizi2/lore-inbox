Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751280AbWIOLdR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751280AbWIOLdR (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Sep 2006 07:33:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751282AbWIOLdR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Sep 2006 07:33:17 -0400
Received: from wx-out-0506.google.com ([66.249.82.230]:53236 "EHLO
	wx-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1751280AbWIOLdQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Sep 2006 07:33:16 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:sender:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        b=iHddRyTDopNE3QgTZAtfrNczXWCQ550SwwZ9ZS5GtThlF1oE7yIqg/B9+UZIrPjNcfCC/JVkSJNiFF02oIbrdEcZ6DOps0U1McmW31AYvBixRH78zhRxjLuziIXrN6wtkTNR3KW/rzSbnRSrSC/yWoI4gG/Yaj4M7XKK9cHiIx0=
Message-ID: <e6ec3ad10609150433x19803d2dw4dbfc604a672d42a@mail.gmail.com>
Date: Fri, 15 Sep 2006 13:33:16 +0200
From: "Marcin Juszkiewicz" <openembedded@hrw.one.pl>
To: "John Shillinglaw" <ianchas@sc.rr.com>, linux-kernel@vger.kernel.org
Subject: Re: Sharp Zaurus SL-5500 SD reader in 2.6.18-rc6
In-Reply-To: <1158108895.12680.2.camel@Pippin.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <1158108895.12680.2.camel@Pippin.home>
X-Google-Sender-Auth: bcef41ae7db00bd4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/13/06, John Shillinglaw <ianchas@sc.rr.com> wrote:

> Can anyone tell me the status of support for the locomo based sd/mmc
> reader in the Sharp Zaurus sl-5500 for either the 2.6.18-rc6 kernel or
> in 2.6.18-rc6-mm2 ?

No one has documentation for chipset used to drive SD/MMC controler.
All we know is that it use some kind of SPI interface through the
LOCOMO chip (as far as I know) which we have no documentation on.

There was discussion about it few weeks ago on lkml.
