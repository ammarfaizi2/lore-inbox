Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267431AbUHJPoq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267431AbUHJPoq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Aug 2004 11:44:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267468AbUHJPoq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Aug 2004 11:44:46 -0400
Received: from hell.org.pl ([212.244.218.42]:36872 "HELO hell.org.pl")
	by vger.kernel.org with SMTP id S267431AbUHJPon (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Aug 2004 11:44:43 -0400
Date: Tue, 10 Aug 2004 17:44:46 +0200
From: Karol Kozimor <sziwan@hell.org.pl>
To: Len Brown <len.brown@intel.com>
Cc: eric.valette@free.fr, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.8-rc4-mm1 : Hard freeze due to ACPI
Message-ID: <20040810154446.GB22863@hell.org.pl>
References: <41189098.4000400@free.fr> <4118A500.1080306@free.fr> <1092151779.5028.40.camel@dhcppc4>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
In-Reply-To: <1092151779.5028.40.camel@dhcppc4>
User-Agent: Mutt/1.4.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thus wrote Len Brown:
> I'll poke around the mm patch to see if anything else looks suspicious.

I remember my problem (with 2.6.8-rc3-mm1, I suppose) was a sort of an ACPI
mutex deadlock (or at least that's what the call trace suggested), I'm
sorry I didn't have time to post a proper report, I'm a bit busy right
these days.
Best regards,

-- 
Karol 'sziwan' Kozimor
sziwan@hell.org.pl
