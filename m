Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263488AbTLDTF0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Dec 2003 14:05:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263491AbTLDTF0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Dec 2003 14:05:26 -0500
Received: from bab72-140.optonline.net ([167.206.72.140]:33414 "EHLO
	shookay.newview.com") by vger.kernel.org with ESMTP id S263488AbTLDTFW
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Dec 2003 14:05:22 -0500
Date: Thu, 4 Dec 2003 14:04:07 -0500
From: Mathieu Chouquet-Stringer <mathieu@newview.com>
To: John Stoffel <stoffel@lucent.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: SMP Kernel 2.6.0-test11 doesn't boot on a Dell 410
Message-ID: <20031204190407.GB13748@shookay.newview.com>
Mail-Followup-To: Mathieu Chouquet-Stringer <mathieu@newview.com>,
	John Stoffel <stoffel@lucent.com>, linux-kernel@vger.kernel.org
References: <20031204135415.GA9913@shookay.newview.com> <16335.23048.950612.696818@gargle.gargle.HOWL>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <16335.23048.950612.696818@gargle.gargle.HOWL>
User-Agent: Mutt/1.4.1i
X-Face: %JOeya=Dg!}[/#Go&*&cQ+)){p1c8}u\Fg2Q3&)kothIq|JnWoVzJtCFo~4X<uJ\9cHK'.w 3:{EoxBR
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 04, 2003 at 11:00:08AM -0500, John Stoffel wrote:
> I tried booting with noapic, but it didn't make any difference here.

Here it does (read it works) but I don't have ACPI in the kernel. I'll
recompile one with ACPI and will try (talking about ACPI because someone
from Dell told me to disable it too).

-- 
Mathieu Chouquet-Stringer              E-Mail : mathieu@newview.com
       Never attribute to malice that which can be adequately
                    explained by stupidity.
                     -- Hanlon's Razor --
