Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261693AbTCMBbT>; Wed, 12 Mar 2003 20:31:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261770AbTCMBbT>; Wed, 12 Mar 2003 20:31:19 -0500
Received: from smtp1.clear.net.nz ([203.97.33.27]:23805 "EHLO
	smtp1.clear.net.nz") by vger.kernel.org with ESMTP
	id <S261693AbTCMBbS>; Wed, 12 Mar 2003 20:31:18 -0500
Date: Thu, 13 Mar 2003 14:31:39 +1300
From: Nigel Cunningham <ncunningham@clear.net.nz>
Subject: Re: PowerNow!, cpufreq, and swsusp
In-reply-to: <3e6f6919.1546.10699@saintmail.net>
To: theophile@saintmail.net
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Message-id: <1047519099.2540.22.camel@laptop-linux.cunninghams>
Organization: 
MIME-version: 1.0
X-Mailer: Ximian Evolution 1.2.1
Content-type: text/plain
Content-transfer-encoding: 7bit
References: <3e6f6919.1546.10699@saintmail.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2003-03-13 at 06:06, Christopher Meredith wrote:
> # CONFIG_ACPI_SLEEP is not set

Switching this on will give you /proc/acpi/sleep. Then swsusp should be
a step closer.

Regards,

Nigel


