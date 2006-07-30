Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751089AbWG3If3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751089AbWG3If3 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Jul 2006 04:35:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751197AbWG3If3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Jul 2006 04:35:29 -0400
Received: from eurogra4543-2.clients.easynet.fr ([212.180.52.86]:50309 "HELO
	briare1.heliogroup.fr") by vger.kernel.org with SMTP
	id S1751089AbWG3If3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Jul 2006 04:35:29 -0400
From: Hubert Tonneau <hubert.tonneau@fullpliant.org>
To: linux-kernel@vger.kernel.org
Subject: Re: Linux v2.6.18-rc3
Date: Sun, 30 Jul 2006 12:21:13 GMT
Message-ID: <06ATUBD12@briare1.heliogroup.fr>
X-Mailer: Pliant 96
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Linus Torvalds wrote:
>
> In fact, it's been pretty quiet since too, which I attribute to 2.6.18-rc2
> just being so good

Not 'so good' but 'no boot'

Freeing unused kernel memory: 152 K
Inconsistency detected by ld.so: rtld.c: 1192: ld_main:
Assertion '(void *) ph->p_vaddr == _rtld_local_._dl_sysinfo_dso' failed !
Kernel panic - not syncing: Attempted to kill init !

> but there really hasn't been tons of stuff. 

and the above problem is not solved in rc3

Extra informations:
. 2.6.17 boots fine
. I have not tested 2.6.17-rc1

Off topic information:
With 2.6.17, none of my USB sound cards works; all of them work with 2.6.16

