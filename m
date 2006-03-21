Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751764AbWCUUiH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751764AbWCUUiH (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Mar 2006 15:38:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751773AbWCUUiH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Mar 2006 15:38:07 -0500
Received: from smtp5-g19.free.fr ([212.27.42.35]:39832 "EHLO smtp5-g19.free.fr")
	by vger.kernel.org with ESMTP id S1751764AbWCUUiF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Mar 2006 15:38:05 -0500
Message-ID: <44206428.1080005@free.fr>
Date: Tue, 21 Mar 2006 21:38:00 +0100
From: Laurent Riffard <laurent.riffard@free.fr>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; fr-FR; rv:1.7.12) Gecko/20050920
X-Accept-Language: fr-fr, fr, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: Kernel development list <linux-kernel@vger.kernel.org>,
       reiserfs-list@namesys.com
Subject: Re: 2.6.16-rc6-mm2: reiser4 BUG when unmounting fs
References: <20060318044056.350a2931.akpm@osdl.org> <442061C0.4020702@free.fr>
In-Reply-To: <442061C0.4020702@free.fr>
X-Enigmail-Version: 0.92.1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Le 21.03.2006 21:27, Laurent Riffard a écrit :
> Le 18.03.2006 13:40, Andrew Morton a écrit :
> 
>>ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.16-rc6/2.6.16-rc6-mm2/
> 
>  
> Hello, 
> 
> This BUG is 100% reproducible. Simply boot to runlevel 1 and then 
> unmount a reiser4 fs:

Oops! Somebody already reported it: http://lkml.org/lkml/2006/3/21/88.

Sorry for the noise...
-- 
laurent
