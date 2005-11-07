Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932440AbVKGHeW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932440AbVKGHeW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Nov 2005 02:34:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932445AbVKGHeW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Nov 2005 02:34:22 -0500
Received: from nproxy.gmail.com ([64.233.182.193]:18339 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932440AbVKGHeW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Nov 2005 02:34:22 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:subject:references:content-type:mime-version:content-transfer-encoding:message-id:in-reply-to:user-agent;
        b=lAu9lwfJT1uZclnRb0ME8f8QG9HKMIiNsocO30C1x0yh77nRwQL0xZfZsvv9aqRoRoADgWho9jffui5k0SE1jVgyKEXyY/qJGGldNfjvmMBhk/SPiViyRW/hbX+1p47cju+iPuT4MbRsUb3sMVcZUH/IpxAfaxxGWjL0qfMwwYk=
Date: Mon, 07 Nov 2005 10:35:33 +0300
From: unDEFER <undefer@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: Re: FileSystem, "." and "..", rmdir
References: <op.sztqupcjty9wl4@undecomp>
Content-Type: text/plain; format=flowed; delsp=yes; charset=koi8-r
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-ID: <op.szu0pjlwty9wl4@undecomp>
In-Reply-To: <op.sztqupcjty9wl4@undecomp>
User-Agent: Opera M2/8.50 (Linux, build 1358)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

В письме от Sun, 06 Nov 2005 18:05:03 +0300, unDEFER <undefer@gmail.com> сообщал:

> 1) There are not "<mount-point>/.", "<mount-point>/..", and "<mount-point>/<any_dir>/.." entries,

And the first problem was solved when I change root inode to #1 and reserve inode #0 as not allocatable.

-- 
registered Linux user #360474
Don't worry, I can read OpenOffice.org
