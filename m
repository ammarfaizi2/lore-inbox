Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266408AbSLDLez>; Wed, 4 Dec 2002 06:34:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266409AbSLDLez>; Wed, 4 Dec 2002 06:34:55 -0500
Received: from [195.39.17.254] ([195.39.17.254]:5380 "EHLO Elf.ucw.cz")
	by vger.kernel.org with ESMTP id <S266408AbSLDLey>;
	Wed, 4 Dec 2002 06:34:54 -0500
Date: Wed, 4 Dec 2002 12:41:19 +0100
From: Pavel Machek <pavel@suse.cz>
To: Jochen Hein <jochen@delphi.lan-ks.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [2.5.50, ACPI] link error
Message-ID: <20021204114114.GD309@elf.ucw.cz>
References: <E18Ix71-0003ik-00@gswi1164.jochen.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E18Ix71-0003ik-00@gswi1164.jochen.org>
User-Agent: Mutt/1.4i
X-Warning: Reading this can be dangerous to your mental health.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> When compiling 2.5.50 with CONFIG_ACPI_SLEEP=y

Enable SWSUSP... Then investigate why it is possible to select
ACPI_SLEEP but not SWSUSP...
							Pavel

-- 
Worst form of spam? Adding advertisment signatures ala sourceforge.net.
What goes next? Inserting advertisment *into* email?
