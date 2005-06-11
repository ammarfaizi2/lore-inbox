Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261836AbVFKVnJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261836AbVFKVnJ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Jun 2005 17:43:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261838AbVFKVnJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Jun 2005 17:43:09 -0400
Received: from mout2.freenet.de ([194.97.50.155]:62388 "EHLO mout2.freenet.de")
	by vger.kernel.org with ESMTP id S261836AbVFKVnG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Jun 2005 17:43:06 -0400
Message-ID: <42AB5AAB.2030303@freenet.de>
Date: Sat, 11 Jun 2005 23:42:03 +0200
From: Carsten Otte <cotte@freenet.de>
User-Agent: Debian Thunderbird 1.0.2 (X11/20050331)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: li nux <lnxluv@yahoo.com>
CC: linux <linux-kernel@vger.kernel.org>
Subject: Re: 2.6: problem with module tainting the kernel
References: <20050610152450.82261.qmail@web33315.mail.mud.yahoo.com>
In-Reply-To: <20050610152450.82261.qmail@web33315.mail.mud.yahoo.com>
X-Enigmail-Version: 0.91.0.0
OpenPGP: id=F8391255
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

li nux wrote:

>In 2.6 kernels how to assure that on inserting our own
>module, it doesn't throw the warning:
>
>"unsupported module, tainting kernel"
>
>what tainting depends on apart from the license string ?
>  
>
Guess you're using a SuSE Kernel? That one gets tainted once you
load a module that SuSE does not support (meaning, you cannot call
them and complain about the module). No technical problem.

cheers,
Carsten
