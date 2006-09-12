Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965145AbWILJXH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965145AbWILJXH (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Sep 2006 05:23:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965158AbWILJXH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Sep 2006 05:23:07 -0400
Received: from embla.aitel.hist.no ([158.38.50.22]:12263 "HELO
	embla.aitel.hist.no") by vger.kernel.org with SMTP id S965145AbWILJXE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Sep 2006 05:23:04 -0400
Message-ID: <45067BAF.8070603@aitel.hist.no>
Date: Tue, 12 Sep 2006 11:19:43 +0200
From: Helge Hafting <helge.hafting@aitel.hist.no>
User-Agent: Thunderbird 1.5.0.5 (X11/20060812)
MIME-Version: 1.0
To: Andy Whitcroft <apw@shadowen.org>
CC: Andrew Morton <akpm@osdl.org>, James.Bottomley@SteelEye.com,
       linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: Re: [PATCH] BODGE scsi misc module reference count checks with no
 MODULE_UNLOAD
References: <45067632.4020906@shadowen.org> <20060912090223.GA31576@shadowen.org>
In-Reply-To: <20060912090223.GA31576@shadowen.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andy Whitcroft wrote:
> BODGE scsi misc module reference count checks with no MODULE_UNLOAD
>
> A quick bodge to try and get this to compile for testing.
>
> Signed-off-by: Andy Whitcroft <apw@shadowen.org>
Thanks, this was necessary to compile a non-modular kernel.

Helge Hafting
