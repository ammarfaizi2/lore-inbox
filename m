Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271073AbTHCKgc (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Aug 2003 06:36:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271118AbTHCKgc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Aug 2003 06:36:32 -0400
Received: from 213-0-201-149.dialup.nuria.telefonica-data.net ([213.0.201.149]:19337
	"EHLO dardhal.mired.net") by vger.kernel.org with ESMTP
	id S271073AbTHCKga (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Aug 2003 06:36:30 -0400
Date: Sun, 3 Aug 2003 12:36:28 +0200
From: Jose Luis Domingo Lopez <linux-kernel@24x7linux.com>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.6.0-test2-mm3
Message-ID: <20030803103628.GA2609@localhost>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <3F2C7A03.6080204@terra.com.br>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3F2C7A03.6080204@terra.com.br>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday, 02 August 2003, at 23:57:07 -0300,
Raphael Kubo da Costa wrote:

> Ok, here's my first patch. ;)
> This is a fix for i386's fpu_system.h, which was causing an error during 
> the compilation of fpu_entry.c.
> 
> --- linux-2.6.0-test2-mm3/arch/i386/math-emu/fpu_system.h	2003-08-02 
> 22:54:44.000000000 -0300
> +++ linux-2.6.0-test2-mm3-fix/arch/i386/math-emu/fpu_system.h	2003-08-02 
> 22:53:55.000000000 -0300
> @@ -22,7 +22,7 @@
> 
Your mailer seems to have messed up newlines, so the patch (that I have
no idea if its correct or not) won't apply ;-)

Regards,

-- 
Jose Luis Domingo Lopez
Linux Registered User #189436     Debian Linux Sid (Linux 2.6.0-test2-mm2)
