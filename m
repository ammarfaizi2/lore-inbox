Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965629AbWKEVQl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965629AbWKEVQl (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Nov 2006 16:16:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965688AbWKEVQl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Nov 2006 16:16:41 -0500
Received: from anchor-post-32.mail.demon.net ([194.217.242.90]:63500 "EHLO
	anchor-post-32.mail.demon.net") by vger.kernel.org with ESMTP
	id S965629AbWKEVQk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Nov 2006 16:16:40 -0500
Message-ID: <454E54B6.5010206@superbug.co.uk>
Date: Sun, 05 Nov 2006 21:16:38 +0000
From: James Courtier-Dutton <James@superbug.co.uk>
User-Agent: Thunderbird 1.5.0.7 (X11/20061020)
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: i387  Floating Point Unit (FPU) testing
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

The kernel contains some i387 FPU emulation code.
Is there any user land software to test the FPU emulation code?
I would like to be able to prove the correctness of the FPU emulation 
code in the Linux kernel, and also port the test program to other 
platforms that utilize FPU emulation. For example, DOS emulators like 
DOSBOX.

James

