Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262884AbSKYV1T>; Mon, 25 Nov 2002 16:27:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265683AbSKYV1T>; Mon, 25 Nov 2002 16:27:19 -0500
Received: from dell-paw-3.cambridge.redhat.com ([195.224.55.237]:34296 "EHLO
	passion.cambridge.redhat.com") by vger.kernel.org with ESMTP
	id <S262884AbSKYV1S>; Mon, 25 Nov 2002 16:27:18 -0500
X-Mailer: exmh version 2.5 13/07/2001 with nmh-1.0.4
From: David Woodhouse <dwmw2@infradead.org>
X-Accept-Language: en_GB
In-Reply-To: <20021125181259.GB5302@atrey.karlin.mff.cuni.cz> 
References: <20021125181259.GB5302@atrey.karlin.mff.cuni.cz>  <20021125121545.GA22915@suse.de> <4.3.2.7.2.20021119134830.00b53680@mail.dns-host.com> <20021119130728.GA28759@suse.de> <20021119142731.GF27595@poup.poupinou.org> <20021119164550.GQ11952@fs.tum.de> <20021123195720.GA310@elf.ucw.cz> <4020.1038240431@passion.cambridge.redhat.com> 
To: Pavel Machek <pavel@suse.cz>
Cc: Dave Jones <davej@codemonkey.org.uk>, Adrian Bunk <bunk@fs.tum.de>,
       Ducrot Bruno <poup@poupinou.org>,
       Margit Schubert-While <margit@margit.com>, linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.20 ACPI 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Mon, 25 Nov 2002 21:34:18 +0000
Message-ID: <13297.1038260058@passion.cambridge.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


pavel@suse.cz said:
>  I have omnibook xe3, will boot without ACPI but USB will not work due
> to interrupt routing problems. It has buggy PIR$ table, acpi tables
> are okay. Of course it is HP bug.

BIOS authors are universally shite. Film at 11. 

If it didn't have working ACPI tables either, what would we do? Probably fix
it with a DMI table entry. This box probably doesn't actually require ACPI
to boot. 

--
dwmw2


