Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271151AbTGPVyD (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Jul 2003 17:54:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271149AbTGPVyD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Jul 2003 17:54:03 -0400
Received: from ss1000.ms.mff.cuni.cz ([195.113.19.221]:5544 "EHLO
	ss1000.ms.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S271147AbTGPVxZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Jul 2003 17:53:25 -0400
Date: Thu, 17 Jul 2003 00:08:09 +0200
From: Rudo Thomas <thomr9am@ss1000.ms.mff.cuni.cz>
To: Christian Axelsson <smiler@lanil.mine.nu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [2.6.0-test1-mm1] Compile varnings
Message-ID: <20030717000809.A31582@ss1000.ms.mff.cuni.cz>
Mail-Followup-To: Christian Axelsson <smiler@lanil.mine.nu>,
	linux-kernel@vger.kernel.org
References: <1058387502.13489.2.camel@sm-wks1.lan.irkk.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <1058387502.13489.2.camel@sm-wks1.lan.irkk.nu>; from smiler@lanil.mine.nu on Wed, Jul 16, 2003 at 10:31:42PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Note that this one is still here:
> 
>   AS      arch/i386/boot/setup.o
> arch/i386/boot/setup.S: Assembler messages:
> arch/i386/boot/setup.S:165: Warning: value 0x37ffffff truncated to
> 0x37ffffff

I believe this is a bug in the assembler (binutils)...

Rudo.
