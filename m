Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1753889AbWKGBLP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753889AbWKGBLP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Nov 2006 20:11:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753910AbWKGBLO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Nov 2006 20:11:14 -0500
Received: from terminus.zytor.com ([192.83.249.54]:28099 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S1753762AbWKGBLO
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Nov 2006 20:11:14 -0500
Message-ID: <454FDD27.6000506@zytor.com>
Date: Mon, 06 Nov 2006 17:11:03 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Thunderbird 1.5.0.7 (X11/20060913)
MIME-Version: 1.0
To: James Courtier-Dutton <James@superbug.co.uk>
CC: linux-kernel@vger.kernel.org
Subject: Re: i387  Floating Point Unit (FPU) testing
References: <454E54B6.5010206@superbug.co.uk>
In-Reply-To: <454E54B6.5010206@superbug.co.uk>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

James Courtier-Dutton wrote:
> Hi,
> 
> The kernel contains some i387 FPU emulation code.
> Is there any user land software to test the FPU emulation code?
> I would like to be able to prove the correctness of the FPU emulation 
> code in the Linux kernel, and also port the test program to other 
> platforms that utilize FPU emulation. For example, DOS emulators like 
> DOSBOX.
> 

The i387 FPU emulation code is originally from DJGPP, I believe.

	-hpa
