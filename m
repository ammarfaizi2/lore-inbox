Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265550AbUAPP42 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Jan 2004 10:56:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265546AbUAPPxq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Jan 2004 10:53:46 -0500
Received: from [217.73.129.129] ([217.73.129.129]:39810 "EHLO linuxhacker.ru")
	by vger.kernel.org with ESMTP id S265493AbUAPPxH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Jan 2004 10:53:07 -0500
Date: Fri, 16 Jan 2004 17:52:33 +0200
Message-Id: <200401161552.i0GFqXWU012657@car.linuxhacker.ru>
From: Oleg Drokin <green@linuxhacker.ru>
Subject: Re: [2.4.18]: Reiserfs: vs-2120: add_save_link: insert_item	returned -28
To: reiser@namesys.com, linux-kernel@vger.kernel.org
References: <200401091622.41352.lkml@kcore.org> <1074241063.2251.41.camel@tribesman.namesys.com> <4007A54A.3030005@namesys.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

Hans Reiser <reiser@namesys.com> wrote:
>>>vs-2120: add_save_link: insert_item returned -28
>>This is just a warning. You should be able to free some disk space by
>>removing some files.
HR> why do we generate this warning?  It should be fixed, yes?

Yes, it is fixed in newer kernels.

Bye,
    Oleg
