Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264461AbTKNADl (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Nov 2003 19:03:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264463AbTKNADl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Nov 2003 19:03:41 -0500
Received: from hell.org.pl ([212.244.218.42]:46350 "HELO hell.org.pl")
	by vger.kernel.org with SMTP id S264461AbTKNADk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Nov 2003 19:03:40 -0500
Date: Fri, 14 Nov 2003 01:03:44 +0100
From: Karol Kozimor <sziwan@hell.org.pl>
To: Michael Frank <mhf@linuxmail.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.22 hangs upon echo > /proc/acpi/alarm
Message-ID: <20031114000344.GA23339@hell.org.pl>
References: <Retd.1TR.7@gated-at.bofh.it> <RuoB.4pK.25@gated-at.bofh.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
In-Reply-To: <RuoB.4pK.25@gated-at.bofh.it>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thus wrote Michael Frank:
> Thank you for your reply. I'll make good use of kdb_printf in future.
> 
> In this case however the messages did not even go into the dmesg buffer
> as the acpi debug output (via its own printf) must be enabled by debug 
> section flags which were disabled. I'll file a bug report against acpi asap.

See http://bugme.osdl.org/show_bug.cgi?id=1320.
Best regards,

-- 
Karol 'sziwan' Kozimor
sziwan@hell.org.pl
