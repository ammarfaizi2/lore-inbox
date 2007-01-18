Return-Path: <linux-kernel-owner+w=401wt.eu-S932591AbXARUeW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932591AbXARUeW (ORCPT <rfc822;w@1wt.eu>);
	Thu, 18 Jan 2007 15:34:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932600AbXARUeW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Jan 2007 15:34:22 -0500
Received: from mail.lysator.liu.se ([130.236.254.3]:49721 "EHLO
	mail.lysator.liu.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932591AbXARUd5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Jan 2007 15:33:57 -0500
From: "Jonas Svensson" <jonass@lysator.liu.se>
Organization: http://www.lysator.liu.se/
To: linux-kernel@vger.kernel.org
Date: Thu, 18 Jan 2007 21:33:53 +0100
MIME-Version: 1.0
Subject: Re: trouble loading self compiled vanilla kernel
Reply-To: jonass@lysator.liu.se
Cc: jonass@lysator.liu.se
Message-ID: <45AFE7C1.15906.A6CCC72@jonass.lysator.liu.se>
In-reply-to: <1168278054.3330.4.camel@impinj-lt-0046>
References: <Pine.GSO.4.51L2.0701081054010.27141@nema.lysator.liu.se>, <Pine.GSO.4.51L2.0701081644110.27141@nema.lysator.liu.se>, <1168278054.3330.4.camel@impinj-lt-0046>
X-mailer: Pegasus Mail for Windows (4.41)
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Content-description: Mail message body
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 8 Jan 2007 at 9:40, Vadim Lobanov wrote:

> In my experience on openSUSE, the following sequence of commands
> installs both the kernel and the initrd:
> 	make *config*
> 	make
> 	make modules_install
> 	make install
> However, if the order of the last two make invocations is switched, then
> the initrd does not get generated (correctly or at all). Although
> unlikely to be the problem, it's a simple thing to eliminate from the
> list of possible borkages.
> 
> -- Vadim Lobanov

Thank you for your advice. It's been a while and I have been some 
testing. I can compile and boot these kernels: 2.6.10, 2.6.16.37 
and 2.6.17.14. But I have not been able to boot any of these: 
2.6.18, 2.6.18.6 nor 2.6.19.1. Guess I will have to read the 
changelog for 2.6.18 really careful.

/Jonas

