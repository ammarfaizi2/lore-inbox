Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262898AbUDANAf (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Apr 2004 08:00:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262896AbUDANAf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Apr 2004 08:00:35 -0500
Received: from qfep05.superonline.com ([212.252.122.161]:38366 "EHLO
	qfep05.superonline.com") by vger.kernel.org with ESMTP
	id S262899AbUDANAe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Apr 2004 08:00:34 -0500
Message-ID: <406C11C5.2030102@superonline.com>
Date: Thu, 01 Apr 2004 15:57:41 +0300
From: "O.Sezer" <sezero@superonline.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20030225
X-Accept-Language: tr, en-us, en
MIME-Version: 1.0
To: "O.Sezer" <sezero@superonline.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: [BKPATCH] ACPI for 2.4
References: <406C0A14.6060302@superonline.com>
In-Reply-To: <406C0A14.6060302@superonline.com>
Content-Type: text/plain; charset=ISO-8859-9; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>  > <len.brown@intel.com> (04/04/01 1.1063.46.95)
>  >    [ACPI] Restore PIC-mode SCI default to Level Trigger (David Shaohua
>  > Li)
>  >    http://bugme.osdl.org/show_bug.cgi?id=2382

[...]

> This fixed the issue I reported about the power button not
> functioning in 26-rc1.
> 

Further, vanilla 26-rc1 also shuts down fine with the power button
if booted with a kernel parameter "acpi_sci=level" (_not_ edge, as
stated in the above bugzilla entry).

Regards;
Özkan Sezer

