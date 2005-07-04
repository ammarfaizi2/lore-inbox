Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261362AbVGDQ5L@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261362AbVGDQ5L (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Jul 2005 12:57:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261418AbVGDQ5L
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Jul 2005 12:57:11 -0400
Received: from wproxy.gmail.com ([64.233.184.198]:6296 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261362AbVGDQ5G (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Jul 2005 12:57:06 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:subject:from:reply-to:to:cc:in-reply-to:references:content-type:date:message-id:mime-version:x-mailer:content-transfer-encoding;
        b=DxzUV5CbT8J3UYYBMA7neXZ6sIFPey5JXN1ZspN9N5xqBpjs/43y6JQEKnIbiE0yC7ShxlHHxyx+iP7EeJcqJFCxzYzyznMiEqSfwdGqIXmerjyeuM2AGDn3rnwHIEwmLtRu/o9zLi0ig3Os/cjn8S+Af7BmGfaU4VwX8ekDIq8=
Subject: Re: notebook buttons trouble, acpi related
From: Hetfield <hetfield666@gmail.com>
Reply-To: hetfield666@gmail.com
To: Matthew Garrett <mgarrett@chiark.greenend.org.uk>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <E1DpTqG-00038x-00@chiark.greenend.org.uk>
References: <1120493152.17493.30.camel@blight.blightgroup>
	 <E1DpTqG-00038x-00@chiark.greenend.org.uk>
Content-Type: text/plain
Date: Mon, 04 Jul 2005 18:57:00 +0200
Message-Id: <1120496221.17493.38.camel@blight.blightgroup>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Il giorno lun, 04/07/2005 alle 17.30 +0100, Matthew Garrett ha scritto:
> Hetfield <hetfield666@gmail.com> wrote:
> 
> > if it turns off tft and change brightness i guess kernel should receive
> > some events but
> > /proc/acpi/event doesn't get them.
> 
> In general, these keys generate events that are handled by the hardware.
> The kernel never gets told about them. If you disassemble your DSDT, you
> may be able to find methods that correspond to the hotkeys - then you
> can use the ACPI generic hotkey driver to bind them to events. However,
> this isn't always true and is very hardware dependent.
> 
i'm sorry, but i've no idea about how disasseble dsdt and how to use
that.

how can i get support?

(i know the question is google too )

