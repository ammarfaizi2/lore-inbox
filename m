Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261271AbVA0W6L@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261271AbVA0W6L (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Jan 2005 17:58:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261272AbVA0W6L
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Jan 2005 17:58:11 -0500
Received: from pop5-1.us4.outblaze.com ([205.158.62.125]:37287 "HELO
	pop5-1.us4.outblaze.com") by vger.kernel.org with SMTP
	id S261271AbVA0W6H (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Jan 2005 17:58:07 -0500
Subject: Re: Applications segfault on evo n620c with 2.6.10
From: Nigel Cunningham <ncunningham@linuxmail.org>
Reply-To: ncunningham@linuxmail.org
To: Pavel Machek <pavel@ucw.cz>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@zip.com.au>
In-Reply-To: <20050127184334.GA1368@elf.ucw.cz>
References: <20050127184334.GA1368@elf.ucw.cz>
Content-Type: text/plain
Message-Id: <1106866666.15825.21.camel@nigelcunningham>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6-1mdk 
Date: Fri, 28 Jan 2005 09:57:46 +1100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

On Fri, 2005-01-28 at 05:43, Pavel Machek wrote:
> Unfortunately I do not know how to reproduce it. I tried
> parallel-building kernels for few hours and that worked okay. Swsusp
> is not involved (but usb, bluetooth, acpi and sound may be).

I take it you're sure suspending is not involved because it happens
before you've ever suspended? If you hadn't said that, I'd say it sounds
very much like something suspend related.

Regards,

Nigel
-- 
Nigel Cunningham
Software Engineer
Cyclades Corporation

http://cyclades.com

