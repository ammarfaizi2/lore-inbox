Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264267AbUAIXqs (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jan 2004 18:46:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264286AbUAIXqs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jan 2004 18:46:48 -0500
Received: from arhont1.eclipse.co.uk ([81.168.98.121]:64223 "EHLO
	pingo.core.arhont.com") by vger.kernel.org with ESMTP
	id S264267AbUAIXqq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jan 2004 18:46:46 -0500
Message-ID: <3FFF3D5B.7040601@arhont.com>
Date: Fri, 09 Jan 2004 23:46:35 +0000
From: Andrei Mikhailovsky <andrei@arhont.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20031107 Debian/1.5-3
X-Accept-Language: en
MIME-Version: 1.0
To: Brice Goglin <Brice.Goglin@ens-lyon.fr>
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.6.1 make menuconfig error
References: <20040109141455.GJ4485@ens-lyon.fr>
In-Reply-To: <20040109141455.GJ4485@ens-lyon.fr>
X-Enigmail-Version: 0.76.7.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.9 (----)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Yeah, it happens to me to. The same problem happens with -mm1 patch.

Andrei

Brice Goglin wrote:
> Hi,
> 
> When configuring 2.6.1 with make menuconfig,
> if I choose not to save my configuration changes,
> I get this error:
> 
> 
> puligny:~/build/linux-2.6.1% make menuconfig
> make[1]: scripts/fixdep' is up to date.
> scripts/kconfig/mconf arch/i386/Kconfig
> #
> # using defaults found in .config
> #
> 
> 
> Your kernel configuration changes were NOT saved.
> 
> make[1]: *** [menuconfig] Error 1
> make: *** [menuconfig] Error 2
> puligny:~/build/linux-2.6.1%
> 
> 
> 2.6.0 does not show such two error lines.
> 
> Best regards.



