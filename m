Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270173AbTGUQA0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Jul 2003 12:00:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270189AbTGUQAZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Jul 2003 12:00:25 -0400
Received: from hell.org.pl ([212.244.218.42]:53518 "HELO hell.org.pl")
	by vger.kernel.org with SMTP id S270173AbTGUQAU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Jul 2003 12:00:20 -0400
Date: Mon, 21 Jul 2003 18:18:00 +0200
From: Karol Kozimor <sziwan@hell.org.pl>
To: Eric Valette <eric.valette@free.fr>
Cc: Mikael Pettersson <mikpe@csd.uu.se>, akpm@osdl.org,
       andrew.grover@intel.com, acpi-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
Subject: Re: [ACPI] Re: [PATCH] Linux 2.6-pre-mm2 Fix crash on boot on ASUS L3800C if enabing APIC => add this machine to DMI black list
Message-ID: <20030721161800.GB28083@hell.org.pl>
Mail-Followup-To: Eric Valette <eric.valette@free.fr>,
	Mikael Pettersson <mikpe@csd.uu.se>, akpm@osdl.org,
	andrew.grover@intel.com, acpi-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org
References: <200307210114.h6L1El7M018996@harpo.it.uu.se> <3F1B9F37.509@free.fr> <3F1C0DEE.8040509@free.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
In-Reply-To: <3F1C0DEE.8040509@free.fr>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thus wrote Eric Valette:
> Come on, APM is a thing from the past and any recent laptop does not 
> even care of supporting it now that Windows XP is  bundled... And in any 
> case it is not supported by this particular machine...

While I agree with your first statement, I must object to the second: this
laptop, contrary to what the manual says, supports APM quite well indeed.
Anyway, turning ACPI off is not a solution.
Best regards,

-- 
Karol 'sziwan' Kozimor
sziwan@hell.org.pl
