Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262288AbTLWSQt (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Dec 2003 13:16:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262280AbTLWSQs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Dec 2003 13:16:48 -0500
Received: from eta.fastwebnet.it ([213.140.2.50]:33718 "EHLO eta.fastwebnet.it")
	by vger.kernel.org with ESMTP id S262288AbTLWSQj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Dec 2003 13:16:39 -0500
Subject: Re: Ooops with kernel 2.4.22 and reiserfs
From: Carlo <devel@integra-sc.it>
To: Oleg Drokin <green@linuxhacker.ru>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20031223152014.GG2099@linuxhacker.ru>
References: <1072126808.21200.3.camel@atena>
	 <200312222205.hBMM5vLv012067@car.linuxhacker.ru>
	 <1072173894.21198.36.camel@atena>  <20031223152014.GG2099@linuxhacker.ru>
Content-Type: text/plain
Message-Id: <1072203437.21198.101.camel@atena>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Tue, 23 Dec 2003 19:17:18 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Il mar, 2003-12-23 alle 16:20, Oleg Drokin ha scritto:

> Sounds like a list corruption to me.
> Are you sure the memory in that box is ok?
> 
This PC has never gave memory problems and we use it in extensive mode. 

> Run it through ksymoops and see if backtrace is different each time.
> Usually only first oops per boot is useful.
> If backtrace is different each time, perhaps list all unique oopses?
> 
I run it several time with the same result.
I think thah it's a bug that is hardware dependant, because the same
program on another PC with the same HW but different MainBoard run
without problems
> Thank you.
Thank you too
Saluti Carlo!
> 
> Bye,
>     Oleg

