Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263320AbTDWJWO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Apr 2003 05:22:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263338AbTDWJWO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Apr 2003 05:22:14 -0400
Received: from pointblue.com.pl ([62.89.73.6]:28166 "EHLO pointblue.com.pl")
	by vger.kernel.org with ESMTP id S263320AbTDWJWM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Apr 2003 05:22:12 -0400
Subject: Re: emu10k1 hang with dlink-520+ or acx100 network card
From: Grzegorz Jaskiewicz <gj@pointblue.com.pl>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1051021625.858.1.camel@flat41>
References: <1051020930.566.2.camel@flat41>  <1051021625.858.1.camel@flat41>
Content-Type: text/plain
Organization: K4 Labs
Message-Id: <1051090439.9095.3.camel@gregs>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 23 Apr 2003 10:34:09 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2003-04-22 at 15:27, Grzegorz Jaskiewicz wrote:
> Just after i placed my new dlink-520+ card and boot it, kernel hangs
> after emu10k1 initialization. loading it as a module solves problem (it
> does not hang while loading), but it hangs if i will do cat /dev/urandom
> >/dev/sound/dsp with "Spurious 8259A interrupt: IRQ 7". This happends
> both on 2.5.68 and 2.4.21-rc1.
> 
> lspci -vvv and .config included.
Any chance to get any response from you guys ?

-- 
Grzegorz Jaskiewicz <gj@pointblue.com.pl>
K4 Labs

