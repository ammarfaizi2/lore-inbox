Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269379AbTGUHtn (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Jul 2003 03:49:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269334AbTGUHtn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Jul 2003 03:49:43 -0400
Received: from postfix3-2.free.fr ([213.228.0.169]:36527 "EHLO
	postfix3-2.free.fr") by vger.kernel.org with ESMTP id S269392AbTGUHtl
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Jul 2003 03:49:41 -0400
Message-ID: <3F1B9F37.509@free.fr>
Date: Mon, 21 Jul 2003 10:07:19 +0200
From: Eric Valette <eric.valette@free.fr>
Reply-To: eric.valette@free.fr
Organization: HOME
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030624
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Mikael Pettersson <mikpe@csd.uu.se>
Cc: akpm@osdl.org, andrew.grover@intel.com, sziwan@hell.org.pl,
       acpi-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Linux 2.6-pre-mm2 Fix crash on boot on ASUS L3800C if
 enabing APIC => add this machine to DMI black list
References: <200307210114.h6L1El7M018996@harpo.it.uu.se>
In-Reply-To: <200307210114.h6L1El7M018996@harpo.it.uu.se>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mikael Pettersson wrote:

> While I don't dispute your machine has some problem, please
> do the following first before we completely blacklist it:
> - ensure you have the latest BIOS (ftp.asuscom.de has the ones for
>   their desktop mainboards, presumably the laptop BIOSen are also there)

Have the latest BIOS from 3 June...

> - in what way is ACPI mandatory? does it fail to boot, or does it
>   just lose some specific feature? If you just want suspend support,
>   try APM if the machine has it

Many ACPI managed buttons, Fans, ...

-- 
    __
   /  `                   	Eric Valette
  /--   __  o _.          	6 rue Paul Le Flem
(___, / (_(_(__         	35740 Pace

Tel: +33 (0)2 99 85 26 76	Fax: +33 (0)2 99 85 26 76
E-mail: eric.valette@free.fr

