Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272783AbTG3GhU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Jul 2003 02:37:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272786AbTG3GhT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Jul 2003 02:37:19 -0400
Received: from pop.gmx.net ([213.165.64.20]:39552 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S272783AbTG3GgI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Jul 2003 02:36:08 -0400
From: Helge Deller <deller@gmx.de>
To: Eli Carter <eli.carter@inet.com>, John Bradford <john@grabjohn.com>
Subject: Re: PATCH : LEDs - possibly the most pointless kernel subsystem ever
Date: Wed, 30 Jul 2003 08:37:09 +0200
User-Agent: KMail/1.5.9
Cc: linux-kernel@vger.kernel.org, pgw99@doc.ic.ac.uk
References: <200307292038.h6TKcqlu000338@81-2-122-30.bradfords.org.uk> <3F26DC68.3010000@inet.com>
In-Reply-To: <3F26DC68.3010000@inet.com>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200307300835.49142.deller@gmx.de>
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 29 July 2003 22:43, Eli Carter wrote:
> Maybe also:
>   * 100% CPU usage
>   * Toggle each jiffie (help detect interrupts disabled)
>   * User control for things like cpu/harddrive temp...
>   * and of course, Morse code ;)

Older PA-RISC machines have at the front panel a LED
which shows machine load (4 LEDs), heartbeat (1 LED), 
SCSI activity (1 LED) and network RX/TX (1 LED each).
This panel is programmable via software and a nice and 
consistent linux kernel and userspace API  across the 
architectures is IMHO a good thing.

Helge
