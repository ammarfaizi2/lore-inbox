Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263968AbTHZOMZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Aug 2003 10:12:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263908AbTHZOI2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Aug 2003 10:08:28 -0400
Received: from 153.Red-213-4-13.pooles.rima-tde.net ([213.4.13.153]:34821 "EHLO
	small.felipe-alfaro.com") by vger.kernel.org with ESMTP
	id S263710AbTHZOEN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Aug 2003 10:04:13 -0400
Subject: re: [ACPI] 2.4.22, My bios is to old?
From: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
To: "Tony A. Lambley" <tal@vextech.net>
Cc: LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <1061903560.686.6.camel@lappy2.localdomain>
References: <1061903560.686.6.camel@lappy2.localdomain>
Content-Type: text/plain
Message-Id: <1061906650.678.2.camel@teapot.felipe-alfaro.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 
Date: Tue, 26 Aug 2003 16:04:10 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2003-08-26 at 15:12, Tony A. Lambley wrote:

> I have the same problem on a sager 5600D that's only 8 months old. It
> didn't happen with 2.4.22-rc2, I missed -rc3, but it happens in -rc4. I
> also get it in 2.6.0-test4. Was something back-ported?

Some new ACPI stuff went into 2.4.22 final. Try booting the kernel with
"acpi=force".

