Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262348AbTJATkJ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Oct 2003 15:40:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262457AbTJATkJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Oct 2003 15:40:09 -0400
Received: from hq.pm.waw.pl ([195.116.170.10]:11963 "EHLO hq.pm.waw.pl")
	by vger.kernel.org with ESMTP id S262348AbTJATkG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Oct 2003 15:40:06 -0400
To: <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.0-test5 (nearly) success story
References: <m3k78enooi.fsf@defiant.pm.waw.pl>
From: Krzysztof Halasa <khc@pm.waw.pl>
Date: 01 Oct 2003 21:25:10 +0200
In-Reply-To: <m3k78enooi.fsf@defiant.pm.waw.pl>
Message-ID: <m3u16sep61.fsf@defiant.pm.waw.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Krzysztof Halasa <khc@pm.waw.pl> writes:

> Just compiled and booted 2.6.0-test5 on my Fujitsu-Siemens notebook
> (Liteline LF6, Celeron 600 MHz class, i440BX etc). No modules.

Now test6 and gcc 3.3.1 20030915 (Red Hat Linux 3.3.1-5)

> Problems:
> 1. with cardbus ethernet (DEC tulip 21143-based D-Link DFE-660TX) inserted,
>    boot process stops after printing something like:

Fixed in test6.
-- 
Krzysztof Halasa, B*FH
