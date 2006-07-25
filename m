Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751474AbWGYSdZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751474AbWGYSdZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Jul 2006 14:33:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751476AbWGYSdZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Jul 2006 14:33:25 -0400
Received: from ug-out-1314.google.com ([66.249.92.172]:57973 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1751474AbWGYSdY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Jul 2006 14:33:24 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=VeRQIOJ+7Qh4ie7z2mqistkbidiRJtI4zxOEb3JXWC76rVx/22gCURrOmpzmRRJPEv5Iwz+GfkdjCXawq4ZBbwtsz9XmVBbDYlYNl4yglR//xJfqWNAlLV4glZi9MW11VFnKITmke0deoLYLKCbN3VrQSQ5BSW157k9sv1c4lD8=
Message-ID: <512afbf90607251133ob56f706oc3f39a0198e52f2a@mail.gmail.com>
Date: Tue, 25 Jul 2006 11:33:22 -0700
From: "Kristen Accardi" <kristen.kml@gmail.com>
To: "Meelis Roos" <mroos@linux.ee>
Subject: Re: yenta irq disabled on IBM X20 with dock
Cc: "Linux Kernel list" <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.SOC.4.61.0607240016590.26491@math.ut.ee>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <Pine.SOC.4.61.0607240016590.26491@math.ut.ee>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/23/06, Meelis Roos <mroos@linux.ee> wrote:
> I have a IBM X20 laptop. Works fine without the dock (2 yenta ports with
> Ricoh chips). However, when I power it up in the dock (Type 2631), there
> is a problem with additional yenta ports in the dock (TI ones). The
> disable the IRQ and also kill a USB port (the probable reason behind the
> USB messages, but maybe it's unrelated since the USB messages start
> before the IRQ message). Other than that it works fine in the dock.
>
> Tested with 2.6.17 and 2.6.18-rc2.
>

Hi,
Would you mind seeing if you have the same problem with 2.6.16?
Thanks,
Kristen
