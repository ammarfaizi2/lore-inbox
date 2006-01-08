Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161125AbWAHBbb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161125AbWAHBbb (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Jan 2006 20:31:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161126AbWAHBbb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Jan 2006 20:31:31 -0500
Received: from pilet.ens-lyon.fr ([140.77.167.16]:63158 "EHLO
	pilet.ens-lyon.fr") by vger.kernel.org with ESMTP id S1161125AbWAHBba
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Jan 2006 20:31:30 -0500
Message-ID: <43C06B6F.6070409@gmail.com>
Date: Sat, 07 Jan 2006 20:31:27 -0500
From: Brice Goglin <brice.goglin@gmail.com>
User-Agent: Debian Thunderbird 1.0.7 (X11/20051017)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Ben Collins <bcollins@ubuntu.com>
Cc: linux-kernel@vger.kernel.org, Jean Tourrilhes <jt@hpl.hp.com>
Subject: Re: [PATCH 13/15] irda/nsc-ircc: Add ISAPNP support
References: <0ISL00EQ796X6A@a34-mta01.direcway.com>
In-Reply-To: <0ISL00EQ796X6A@a34-mta01.direcway.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ben Collins wrote:

>Author: Jean Tourrilhes <jt@hpl.hp.com>
>Signed-off-by: Ben Collins <bcollins@ubuntu.com>
>
>---
>
> drivers/net/irda/nsc-ircc.c |  102 +++++++++++++++++++++++++++++++++++++++++--
> 1 files changed, 98 insertions(+), 4 deletions(-)
>  
>
Hi,

Last time I looked at this patch, it was making irda work on my
thinkpad. But Jean told me that it was also breaking things on other
machines. Any news about that ?

Brice

