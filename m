Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262201AbVHCKbM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262201AbVHCKbM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Aug 2005 06:31:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262206AbVHCK24
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Aug 2005 06:28:56 -0400
Received: from zeus1.kernel.org ([204.152.191.4]:12758 "EHLO zeus1.kernel.org")
	by vger.kernel.org with ESMTP id S262208AbVHCK20 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Aug 2005 06:28:26 -0400
From: Grant Coady <lkml@dodo.com.au>
To: lkml@dodo.com.au
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.13-rc5 randconfig kernel build errors
Date: Wed, 03 Aug 2005 19:58:02 +1000
Organization: www.scatter.mine.nu
Reply-To: lkml@dodo.com.au
Message-ID: <1651f199ie23tv14qv8jnnc53m97qdk1uh@4ax.com>
References: <lrque1drc20ev6o6441mn918e753r7vmki@4ax.com>
In-Reply-To: <lrque1drc20ev6o6441mn918e753r7vmki@4ax.com>
X-Mailer: Forte Agent 2.0/32.652
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 02 Aug 2005 22:58:59 +1000, Grant Coady <lkml@dodo.com.au> wrote:

>Greetings,
>
>Preliminary results, better sample (some hundreds) in a day or so.

After 300 random builds, add one more error:
drivers/acpi/osl.c:261: error: `AmlCode' undeclared (first use in this function)
drivers/acpi/osl.c:61:10: empty file name in #include

Cheers,
Grant.

