Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267717AbTACXpX>; Fri, 3 Jan 2003 18:45:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267720AbTACXpX>; Fri, 3 Jan 2003 18:45:23 -0500
Received: from smtpzilla3.xs4all.nl ([194.109.127.139]:33042 "EHLO
	smtpzilla3.xs4all.nl") by vger.kernel.org with ESMTP
	id <S267717AbTACXpW>; Fri, 3 Jan 2003 18:45:22 -0500
Message-ID: <3E15EDD4.98FF8EBF@linux-m68k.org>
Date: Fri, 03 Jan 2003 21:08:52 +0100
From: Roman Zippel <zippel@linux-m68k.org>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.20 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Andrew Walrond <andrew@walrond.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: menuconfig Bug in 2.5.54
References: <3E156D61.2040105@walrond.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Andrew Walrond wrote:

> In the PCI Bus section, setting the pci access method to BIOS or direct
> does not get saved on exit. It always defaults back to "Any" on next
> make menuconfig

Can you send me your .config? I cannot reproduce it here.

bye, Roman

