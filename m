Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946408AbWJTL7g@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946408AbWJTL7g (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Oct 2006 07:59:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946390AbWJTL7g
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Oct 2006 07:59:36 -0400
Received: from ug-out-1314.google.com ([66.249.92.170]:42524 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1946408AbWJTL7f (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Oct 2006 07:59:35 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=googlemail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=iQVryfAw25VkIox4krj60Y8JrRNN1/SVXdFntrMUthE1knGt71tRMXcXoXf0JHUH8+U7VSi4Gcj43yuWg4Q0phG+4S0RG3XLlevvj4c47cpk1PDWA5FHlfPLDkNVqji2LKSvz2Z1L7zXoyTnlZEEgVv6kUriGPBCLnUnCtBVvGc=
Message-ID: <4538BA2E.9040808@googlemail.com>
Date: Fri, 20 Oct 2006 13:59:42 +0200
From: Gabriel C <nix.or.die@googlemail.com>
User-Agent: Thunderbird 1.5.0.7 (X11/20060915)
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: 2.6.19-rc2-mm2
References: <20061020015641.b4ed72e5.akpm@osdl.org>
In-Reply-To: <20061020015641.b4ed72e5.akpm@osdl.org>
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.19-rc2/2.6.19-rc2-mm2/
>
>   
Hello,

I got this on ' make silentoldconfig '

drivers/media/dvb/dvb-usb/Kconfig:72:warning: 'select' used by config
symbol 'DVB_USB_DIB0700' refer to undefined symbol 'DVB_DIB7000M'

Regards

Gabriel
