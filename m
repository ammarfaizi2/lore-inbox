Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262164AbULLWyi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262164AbULLWyi (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Dec 2004 17:54:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262167AbULLWyi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Dec 2004 17:54:38 -0500
Received: from [65.54.233.107] ([65.54.233.107]:62110 "EHLO hotmail.com")
	by vger.kernel.org with ESMTP id S262164AbULLWyY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Dec 2004 17:54:24 -0500
Message-ID: <BAY21-F18905FD4E8F32BE43C85BCF3AA0@phx.gbl>
X-Originating-IP: [206.167.164.155]
X-Originating-Email: [beaudoin_danny@hotmail.com]
From: "Danny Beaudoin" <beaudoin_danny@hotmail.com>
To: linux-kernel@vger.kernel.org
Subject: Typo in kernel configuration (xconfig)
Date: Sun, 12 Dec 2004 17:53:33 -0500
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
X-OriginalArrivalTime: 12 Dec 2004 22:54:02.0591 (UTC) FILETIME=[797C8EF0:01C4E09D]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!
If I'm not at the right place, please forward this to the right person.

In Device Drivers/Graphics Support/Support for frame buffer devices:
"On several non-X86 architectures, the frame buffer device is the
only way to use the graphics hardware."

This should be 'x86' instead, as in the rest of the description.


