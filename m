Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964860AbVL1R6Z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964860AbVL1R6Z (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Dec 2005 12:58:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964863AbVL1R6Z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Dec 2005 12:58:25 -0500
Received: from ns1.suse.de ([195.135.220.2]:26586 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S964860AbVL1R6Y (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Dec 2005 12:58:24 -0500
Message-ID: <8332307.1135792703524.SLOX.WebMail.wwwrun@imap-dhs.suse.de>
Date: Wed, 28 Dec 2005 18:58:23 +0100 (CET)
From: Andreas Kleen <ak@suse.de>
To: Brian Gerst <bgerst@didntduck.org>
Subject: Re: [PATCH] Remove unused apic_write_atomic
Cc: Andrew Morton <akpm@osdl.org>, lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <43B1CE5E.7020801@didntduck.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Priority: 3 (normal)
X-Mailer: SuSE Linux Openexchange Server 4 - WebMail (Build 2.4160)
X-Operating-System: Linux 2.4.21-304-smp i386 (JVM 1.3.1_16)
Organization: SuSE Linux AG
References: <43B1CE5E.7020801@didntduck.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Mi 28.12.2005 00:29 schrieb Brian Gerst <bgerst@didntduck.org>:

> This function is never used for x86_64.
>
> Signed-off-by: Brian Gerst <bgerst@didntduck.org>

Thanks merged.

-Andi


