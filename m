Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267614AbTGTRnW (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Jul 2003 13:43:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267620AbTGTRnW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Jul 2003 13:43:22 -0400
Received: from hell.org.pl ([212.244.218.42]:2823 "HELO hell.org.pl")
	by vger.kernel.org with SMTP id S267614AbTGTRnW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Jul 2003 13:43:22 -0400
Date: Sun, 20 Jul 2003 20:00:50 +0200
From: Karol Kozimor <sziwan@hell.org.pl>
To: Eric Valette <eric.valette@free.fr>
Cc: "Grover, Andrew" <andrew.grover@intel.com>, linux-kernel@vger.kernel.org,
       acpi-devel@lists.sourceforge.net
Subject: Re: Linux 2.6-pre1 Does not boot on ASUS L3800C: lock up in acpi while  "Executing all Devices _STA and_INIT methods"
Message-ID: <20030720180050.GA15700@hell.org.pl>
Mail-Followup-To: Eric Valette <eric.valette@free.fr>,
	"Grover, Andrew" <andrew.grover@intel.com>,
	linux-kernel@vger.kernel.org, acpi-devel@lists.sourceforge.net
References: <F760B14C9561B941B89469F59BA3A847E9702C@orsmsx401.jf.intel.com> <3F1A969C.6060606@free.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
In-Reply-To: <3F1A969C.6060606@free.fr>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thus wrote Eric Valette:
> BTW : I still cannot boot as the radeon framebuffer driver make things 
> unreable. I will stcik with 2.4 for a while...

Boot the framebuffer into 1024x768@60 mode, every other I tried simply
doesn't work.
Best regards,

-- 
Karol 'sziwan' Kozimor
sziwan@hell.org.pl
