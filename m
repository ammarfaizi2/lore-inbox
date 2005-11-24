Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932613AbVKXB5r@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932613AbVKXB5r (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Nov 2005 20:57:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932614AbVKXB5r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Nov 2005 20:57:47 -0500
Received: from smtp103.sbc.mail.re2.yahoo.com ([68.142.229.102]:64934 "HELO
	smtp103.sbc.mail.re2.yahoo.com") by vger.kernel.org with SMTP
	id S932613AbVKXB5q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Nov 2005 20:57:46 -0500
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Marc Koschewski <marc@osknowledge.org>
Subject: Re: Entering BIOS on DELL mobiles - does the kernel prohibit?
Date: Wed, 23 Nov 2005 20:57:43 -0500
User-Agent: KMail/1.8.3
Cc: linux-kernel@vger.kernel.org
References: <20051123155319.GA6970@stiffy.osknowledge.org>
In-Reply-To: <20051123155319.GA6970@stiffy.osknowledge.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200511232057.44022.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 23 November 2005 10:53, Marc Koschewski wrote:
> Hi all,
> 
> first of all, if someone could point me to some information on that
> topic, I would be glad. I didn't find anything on Google.
> 
> The 'problem' is: I remember being able to enter the DELL Inspiron BIOS
> from a running X session (or console) some (long) time ago. I just noticed,
> it no longer works. Does the kernel somehow prohibit to enter the BIOS
> or does the laptop itself stop from doing so (maybe due to a BIOS update).
>

It is only pssible with APM. ACPI "kills" it.

-- 
Dmitry
