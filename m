Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261348AbUJXAr5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261348AbUJXAr5 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Oct 2004 20:47:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261349AbUJXAr5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Oct 2004 20:47:57 -0400
Received: from linux01.gwdg.de ([134.76.13.21]:3999 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S261348AbUJXAry (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Oct 2004 20:47:54 -0400
Date: Sun, 24 Oct 2004 02:47:40 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: David Masover <ninja@slaphack.com>
cc: =?ISO-8859-1?Q?Markus_T=F6rnqvist?= <mjt@nysv.org>,
       linux-kernel@vger.kernel.org, reiserfs-list@namesys.com
Subject: Re: 2.6.9-mm1
In-Reply-To: <417B1574.4090406@slaphack.com>
Message-ID: <Pine.LNX.4.53.0410240246510.31537@yvahk01.tjqt.qr>
References: <20041023165712.GR26192@nysv.org> <417B1574.4090406@slaphack.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>| Stupid question, why have small keys at all?
>|
>| Someone said once that he didn't want to use large keys because they added
>| no value to him and small keys wasted less space. If there are people like
>| this around, burying it is not cool, but if there aren't, maybe small keys
>| should be ripped out?
>|
>Some people don't care about speed but need space.  I'd leave them in on
>general principle, even if no one wants them now.

How much space would be gained after all on, say, a 200 GB partition?



Jan Engelhardt
-- 
Gesellschaft für Wissenschaftliche Datenverarbeitung
Am Fassberg, 37077 Göttingen, www.gwdg.de
