Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267005AbUBGSBh (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Feb 2004 13:01:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267009AbUBGSBh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Feb 2004 13:01:37 -0500
Received: from hermes.domdv.de ([193.102.202.1]:784 "EHLO zeus.domdv.de")
	by vger.kernel.org with ESMTP id S267005AbUBGSBd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Feb 2004 13:01:33 -0500
Message-ID: <402527DE.5080702@domdv.de>
Date: Sat, 07 Feb 2004 19:01:02 +0100
From: Andreas Steinmetz <ast@domdv.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20031022
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
CC: Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>
Subject: Re: Unknown symbol _exit when compiling VMware vmmon.o module
References: <1076175615.798.9.camel@teapot.felipe-alfaro.com>
In-Reply-To: <1076175615.798.9.camel@teapot.felipe-alfaro.com>
X-Enigmail-Version: 0.76.7.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Felipe Alfaro Solana wrote:
> Hi!
> 
> After installing VMware Workstation 4.5.0-7174 and running
> vmware-config.pl, I get the following error when trying to insert
> vmmon.ko into the kernel:
> 
> vmmon: Unknown symbol _exit
> 
> What can I use instead of _exit(code) inside a module?
> Thanks!
> 

If I do interpret this right please read:

http://linux.bkbits.net:8080/linux-2.5/cset@1.1500.1.161?nav=index.html|ChangeSet@-7d


-- 
Andreas Steinmetz
D.O.M. Datenverarbeitung GmbH

