Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261222AbULAFou@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261222AbULAFou (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Dec 2004 00:44:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261231AbULAFot
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Dec 2004 00:44:49 -0500
Received: from fmr19.intel.com ([134.134.136.18]:64215 "EHLO
	orsfmr004.jf.intel.com") by vger.kernel.org with ESMTP
	id S261222AbULAFos (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Dec 2004 00:44:48 -0500
Subject: Re: [ACPI] Re: Fw: ACPI bug causes cd-rom lock-ups (2.6.10-rc2)
From: Len Brown <len.brown@intel.com>
To: Stas Sergeev <stsp@aknet.ru>
Cc: Andrew Morton <akpm@osdl.org>, Linux kernel <linux-kernel@vger.kernel.org>,
       ACPI Developers <acpi-devel@lists.sourceforge.net>,
       Shaohua Li <shaohua.li@intel.com>
In-Reply-To: <1101879708.8028.62.camel@d845pe>
References: <41990138.7080008@aknet.ru> <1101190148.19999.394.camel@d845pe>
	 <41A4CF1C.6090503@aknet.ru> <1101336267.20008.5326.camel@d845pe>
	 <41A621DD.8060102@aknet.ru>  <1101879708.8028.62.camel@d845pe>
Content-Type: text/plain
Organization: 
Message-Id: <1101879871.8026.65.camel@d845pe>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.3 
Date: 01 Dec 2004 00:44:31 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

CONFIG_PNPACPI=y that is...

On Wed, 2004-12-01 at 00:41, Len Brown wrote:
> Thanks for running the tests.
> Please confirm that this patch make the problem go away in the 
> CONFIG_PNP_ACPI=y configuration.
> 
> -Len
> 

