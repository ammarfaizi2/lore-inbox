Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267502AbUHaIrU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267502AbUHaIrU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Aug 2004 04:47:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267487AbUHaIrT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Aug 2004 04:47:19 -0400
Received: from hermine.aitel.hist.no ([158.38.50.15]:20234 "HELO
	hermine.aitel.hist.no") by vger.kernel.org with SMTP
	id S267502AbUHaIrL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Aug 2004 04:47:11 -0400
Message-ID: <41343C0F.5020508@hist.no>
Date: Tue, 31 Aug 2004 10:51:27 +0200
From: Helge Hafting <helge.hafting@hist.no>
User-Agent: Mozilla Thunderbird 0.7.3 (X11/20040830)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.6.9-rc1-mm2 Inconsistent kallsyms
References: <20040830235426.441f5b51.akpm@osdl.org>
In-Reply-To: <20040830235426.441f5b51.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This compiled, but failed anyway (after make mrproper):

  LD      vmlinux
  SYSMAP  System.map
  SYSMAP  .tmp_System.map
Inconsistent kallsyms data, try setting CONFIG_KALLSYMS_EXTRA_PASS
make: *** [vmlinux] Error 1


Helge Hafting
