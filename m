Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263518AbTKYXVY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Nov 2003 18:21:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263702AbTKYXVY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Nov 2003 18:21:24 -0500
Received: from [217.73.129.129] ([217.73.129.129]:23170 "EHLO linuxhacker.ru")
	by vger.kernel.org with ESMTP id S263518AbTKYXVX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Nov 2003 18:21:23 -0500
Date: Wed, 26 Nov 2003 01:21:02 +0200
Message-Id: <200311252321.hAPNL2UU006419@car.linuxhacker.ru>
From: Oleg Drokin <green@linuxhacker.ru>
To: eugene@orm.mipt.ru, linux-kernel@vger.kernel.org
Subject: Re: [BUG] HPT302  IDE controller in linux 2.4.22
In-Reply-To: <3FC3B4DC.4070802@orm.mipt.ru>
X-Newsgroups: linux.kernel
User-Agent: tin/1.5.8-20010221 ("Blue Water") (UNIX) (Linux/2.6.0-test10 (i686))
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

In article <3FC3B4DC.4070802@orm.mipt.ru> you wrote:

ES> We have an HPT302 IDE controller with two channels - primary/secondary
ES> linux-2.4.22 IDE driver recognizes this controller, but fails to 
ES> properly work with two channels simultaneously.

Hm. I have this HPT302 myself and it works good with drives on both
channels (in raid1 as well). Except my kernel is 2.4.23-pre9.

01:03.0 RAID bus controller: Triones Technologies, Inc. HPT302 (rev 01)
md0 : active raid1 hdg1[1] hde1[0]

Bye,
    Oleg
