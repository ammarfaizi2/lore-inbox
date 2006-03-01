Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751947AbWCAXgW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751947AbWCAXgW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Mar 2006 18:36:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751944AbWCAXgW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Mar 2006 18:36:22 -0500
Received: from mail.dvmed.net ([216.237.124.58]:30352 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1751129AbWCAXgV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Mar 2006 18:36:21 -0500
Message-ID: <44062FF1.4010108@pobox.com>
Date: Wed, 01 Mar 2006 18:36:17 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux@dominikbrodowski.net,
       "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>
Subject: Re: [PATCH] pcmcia: add another ide-cs CF card id
References: <200603012259.k21MxBXC013582@hera.kernel.org>
In-Reply-To: <200603012259.k21MxBXC013582@hera.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.0 (/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linux Kernel Mailing List wrote:
> commit 42935656914b813c99f91cbac421fe677a6f34ab
> tree d37a0d20998f4d87a4bd014300f707c3852ef5f9
> parent 82d56e6d2e616bee0e712330bad06b634f007a46
> author David Brownell <david-b@pacbell.net> Wed, 25 Jan 2006 22:36:32 -0800
> committer Dominik Brodowski <linux@dominikbrodowski.net> Wed, 01 Mar 2006 10:52:12 +0100
> 
> [PATCH] pcmcia: add another ide-cs CF card id
> 
> Add another CF card ID.
> 
> Signed-off-by: David Brownell <dbrownell@users.sourceforge.net>
> Signed-off-by: Dominik Brodowski <linux@dominikbrodowski.net>
> 
>  drivers/ide/legacy/ide-cs.c |    1 +
>  1 files changed, 1 insertion(+)

Why was this not CC'd to the IDE maintainer, and linux-ide?

	Jeff


