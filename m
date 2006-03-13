Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751415AbWCMPM4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751415AbWCMPM4 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Mar 2006 10:12:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751091AbWCMPM4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Mar 2006 10:12:56 -0500
Received: from smtp-vbr8.xs4all.nl ([194.109.24.28]:3089 "EHLO
	smtp-vbr8.xs4all.nl") by vger.kernel.org with ESMTP
	id S1751415AbWCMPMz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Mar 2006 10:12:55 -0500
Message-ID: <8963.194.178.120.170.1142262773.squirrel@webmail.xs4all.nl>
In-Reply-To: <20060313132439.9866A32C033@smtpauth00.csee.siteprotect.com>
References: <20060313132439.9866A32C033@smtpauth00.csee.siteprotect.com>
Date: Mon, 13 Mar 2006 16:12:53 +0100 (CET)
Subject: Re: Problem applying Patch to linux 2.6 kernel
From: "Jurriaan Kalkman" <jurriaan@rivierenland.xs4all.nl>
To: "swapnil" <swapnil@spsoftindia.com>
Cc: linux-kernel@vger.kernel.org
Reply-To: jurriaan@rivierenland.xs4all.nl
User-Agent: SquirrelMail/1.4.5
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Hi Jesper,
>
> Thanks for your quick reply.
>
> I have followed the steps suggested by you as follows:
>
> I have change into the kernel source directory:
>
> [root@lustdevp 2.6.11-1.1369_FC4-i686]# pwd
> /usr/src/kernels/2.6.11-1.1369_FC4-i686


Patches apply to kernel sources as downloaded from kernel.org, not to
kernel sources heavily patched by RedHat, and guess which kernel you are
trying to add the patch to ...

BTW: I'm sure the documentation that was pointed out to you by Jesper also
said this.

You'll have to download a 'vanilla' kernel without RedHat patches if you
want to apply a 'vanilla' patch to it. Vanilla in this context means 'as
downloaded from kernel.org', the official sources without patches by
RedHat or others.

Hope this helps,
Jurriaan


