Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272179AbRIEOH6>; Wed, 5 Sep 2001 10:07:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272181AbRIEOHr>; Wed, 5 Sep 2001 10:07:47 -0400
Received: from AMontpellier-201-1-1-55.abo.wanadoo.fr ([193.252.31.55]:26893
	"EHLO awak") by vger.kernel.org with ESMTP id <S272179AbRIEOHg>;
	Wed, 5 Sep 2001 10:07:36 -0400
Subject: Re: ACPI lock-up on kernel init when probing /dev/hde (Promise
	20265R)
From: Xavier Bestel <xavier.bestel@free.fr>
To: Matthias Andree <matthias.andree@stud.uni-dortmund.de>
Cc: Linux-Kernel mailing list <linux-kernel@vger.kernel.org>
In-Reply-To: <20010905155242.A3926@emma1.emma.line.org>
In-Reply-To: <20010905155242.A3926@emma1.emma.line.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.13.99+cvs.2001.08.30.16.57 (Preview Release)
Date: 05 Sep 2001 16:03:22 +0200
Message-Id: <999698603.14164.20.camel@nomade>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On mer, 2001-09-05 at 15:52, Matthias Andree wrote:

> With ACPI, that box dies after the
> 
> hda: WDC AC420400D, ATA DISK drive

... then just try pressing your power button when it hangs. sometimes it
will reset, sometimes it will continue to boot.

	Xav

