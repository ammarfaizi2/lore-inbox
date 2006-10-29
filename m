Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965185AbWJ2PJg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965185AbWJ2PJg (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Oct 2006 10:09:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965186AbWJ2PJg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Oct 2006 10:09:36 -0500
Received: from main.gmane.org ([80.91.229.2]:41427 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S965185AbWJ2PJf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Oct 2006 10:09:35 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Oleg Verych <olecom@flower.upol.cz>
Subject: Re: -W -Wno-unused -Wno-sign-compare compile flags
Date: Sun, 29 Oct 2006 15:09:18 +0000 (UTC)
Organization: Palacky University in Olomouc, experimental physics department.
Message-ID: <slrnek9hdj.2vm.olecom@flower.upol.cz>
References: <web-577743@televic-cs.ru>
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: flower.upol.cz
Mail-Followup-To: LKML <linux-kernel@vger.kernel.org>, Oleg Verych <olecom@flower.upol.cz>
User-Agent: slrn/0.9.8.1pl1 (Debian)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2006-10-29, someone from <predator@mt9.ru> wrote:
> Hello !linux-kernel
>
> Does anybody try to compile latest linux-kernel with -W 
> -Wno-unused -Wno-sign-compare CFLAGS? There is a tons of 
> warnings :(
> Recent versions of grsecurity patches adds this flags to 
> default. When I asked to grsec developers, why did they do 
> that, they answered: to show, how messy linux code is...

Yes, it is. You are welcome to fix it.
____

