Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262127AbTLDNz0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Dec 2003 08:55:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262128AbTLDNz0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Dec 2003 08:55:26 -0500
Received: from bab72-140.optonline.net ([167.206.72.140]:64872 "EHLO
	shookay.newview.com") by vger.kernel.org with ESMTP id S262127AbTLDNzY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Dec 2003 08:55:24 -0500
Date: Thu, 4 Dec 2003 08:54:15 -0500
From: Mathieu Chouquet-Stringer <mathieu@newview.com>
To: linux-kernel@vger.kernel.org
Subject: SMP Kernel 2.6.0-test11 doesn't boot on a Dell 410
Message-ID: <20031204135415.GA9913@shookay.newview.com>
Mail-Followup-To: Mathieu Chouquet-Stringer <mathieu@newview.com>,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
X-Face: %JOeya=Dg!}[/#Go&*&cQ+)){p1c8}u\Fg2Q3&)kothIq|JnWoVzJtCFo~4X<uJ\9cHK'.w 3:{EoxBR
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	Hi all,

I just tried the latest 2.6.0 (test11) on a Dell 410 (a bi-PIII) and the
SMP flavor of this kernel doesn't work at all. The non-smp one works well
(so I know it's not a case of VT/VGA console missing).

It dies (without any error message) after this:
Uncompressing Linux... Ok, booting the kernel

I tried disabling APIC in the BIOS but it doesn't make any difference...

Any idea?
-- 
Mathieu Chouquet-Stringer              E-Mail : mathieu@newview.com
       Never attribute to malice that which can be adequately
                    explained by stupidity.
                     -- Hanlon's Razor --
