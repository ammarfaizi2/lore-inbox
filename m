Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261287AbVEPKu3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261287AbVEPKu3 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 May 2005 06:50:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261415AbVEPKu3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 May 2005 06:50:29 -0400
Received: from news.cistron.nl ([62.216.30.38]:19635 "EHLO ncc1701.cistron.net")
	by vger.kernel.org with ESMTP id S261287AbVEPKuY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 May 2005 06:50:24 -0400
From: dth@picard.cistron.nl (Danny ter Haar)
Subject: Re: 2.6.12-rc4-mm2
Date: Mon, 16 May 2005 10:50:23 +0000 (UTC)
Organization: Cistron
Message-ID: <d69ttf$782$1@news.cistron.nl>
References: <20050516021302.13bd285a.akpm@osdl.org>
X-Trace: ncc1701.cistron.net 1116240623 7426 62.216.30.70 (16 May 2005 10:50:23 GMT)
X-Complaints-To: abuse@cistron.nl
X-Newsreader: trn 4.0-test76 (Apr 2, 2001)
Originator: dth@picard.cistron.nl (Danny ter Haar)
To: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton  <akpm@osdl.org> wrote:
>ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.12-rc4/2.6.12-rc4-mm2/

include/acpi/achware.h:159: warning: `struct acpi_gpe_block_info' declared inside parameter list
include/acpi/achware.h:159: warning: `struct acpi_gpe_xrupt_info' declared inside parameter list
include/acpi/achware.h:159: warning: type defaults to `int' in declaration of `acpi_hw_enable_runtime_gpe_block'
include/acpi/achware.h:159: warning: data definition has no type or storage class
make[2]: *** [arch/x86_64/kernel/time.o] Error 1
make[1]: *** [arch/x86_64/kernel] Error 2
make[1]: Leaving directory `/usr/src/linux-2.6.12-rc4-mm2'
make: *** [stamp-build] Error 2



Debian-amd64
Kernel config: http://newsgate.newsserver.nl/kernel/dotconfig-2.6.12-rc4-mm2

Danny

-- 
The foundation of evil is made up of lies and marketing - UF2004

