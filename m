Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268534AbUHLMmy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268534AbUHLMmy (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Aug 2004 08:42:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268537AbUHLMmx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Aug 2004 08:42:53 -0400
Received: from gw2-tpnet.polcom.net ([80.55.24.42]:19868 "EHLO
	alpha.polcom.net") by vger.kernel.org with ESMTP id S268534AbUHLMjQ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Aug 2004 08:39:16 -0400
Date: Thu, 12 Aug 2004 14:39:04 +0200 (CEST)
From: Grzegorz Kulewski <kangur@polcom.net>
To: Jakub Vana <gugux@centrum.cz>
Cc: linux-kernel@vger.kernel.org
Subject: Re: x86 - Realmode BIOS and Code calling module
In-Reply-To: <20040812093653Z2097836-29040+39160@mail.centrum.cz>
Message-ID: <Pine.LNX.4.60.0408121437420.12649@alpha.polcom.net>
References: <20040812093653Z2097836-29040+39160@mail.centrum.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 12 Aug 2004, Jakub Vana wrote:

> Hello,
>
> I have written Linux Kernel module that allows you to call BIOS interupts, Far services or your own code. It's working on x86 machines with PAE or not PAE enabled(up to 4GB or up to 64GB). It's tested on 2.4.26 and 2.6.7 kernel on P4 machine. I think there is not problem to work on others. Now, I'm preparing DOCs and Demos.
>
> I wrote the module especialy for changing the VESAFB videomode, but It is usable anywhere the BIOS is neaded.
>
> I'm writing you to know this code exists and to ask you for help to add this code to official Kernel distribution.

Did you saw vesafb-tng at http://dev.gentoo.org/~spock/?


Thanks,

Grzegorz Kulewski

