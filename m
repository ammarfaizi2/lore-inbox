Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277347AbRJVAUA>; Sun, 21 Oct 2001 20:20:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277353AbRJVATt>; Sun, 21 Oct 2001 20:19:49 -0400
Received: from Hell.WH8.TU-Dresden.De ([141.30.225.3]:22544 "EHLO
	Hell.WH8.TU-Dresden.De") by vger.kernel.org with ESMTP
	id <S277347AbRJVATm>; Sun, 21 Oct 2001 20:19:42 -0400
Message-ID: <3BD36631.41618DE8@delusion.de>
Date: Mon, 22 Oct 2001 02:20:01 +0200
From: "Udo A. Steinberg" <reality@delusion.de>
Organization: Disorganized
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.12-ac4 i686)
X-Accept-Language: en, de
MIME-Version: 1.0
To: Alan Cox <laughing@shared-source.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.12-ac5
In-Reply-To: <20011022004549.A32210@lightning.swansea.linux.org.uk>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:

> 2.4.12-ac5
> o       Mini-acpi support for using ACPI apic/cpu       (Andrew Henroid,
>         tables (needed for some new IBM stuff)           Richard Schaal,
>         | You must use a command line option to enable   Jun Nakajima,
>         | this for now                                   Arjan van de Ven)
>         | (Submitted by IBM but written by Intel)

Hi Alan,

The acpi stuff doesn't compile.

acpitable.c: In function `__va_range':
acpitable.c:479: `FIX_IO_APIC_BASE_0' undeclared (first use in this function)
acpitable.c:479: (Each undeclared identifier is reported only once
acpitable.c:479: for each function it appears in.)
acpitable.c:496: `FIX_IO_APIC_BASE_END' undeclared (first use in this function)

Regards,
Udo.
