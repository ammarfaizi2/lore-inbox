Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932163AbWHCDdm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932163AbWHCDdm (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Aug 2006 23:33:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932179AbWHCDdl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Aug 2006 23:33:41 -0400
Received: from smtp.osdl.org ([65.172.181.4]:9131 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932163AbWHCDdl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Aug 2006 23:33:41 -0400
Date: Wed, 2 Aug 2006 20:33:36 -0700
From: Andrew Morton <akpm@osdl.org>
To: Stas Sergeev <stsp@aknet.ru>
Cc: zach@vmware.com, linux-kernel@vger.kernel.org
Subject: Re: [patch] espfix cleanup take 2
Message-Id: <20060802203336.c4f8a428.akpm@osdl.org>
In-Reply-To: <44D0D643.6090108@aknet.ru>
References: <44D0D643.6090108@aknet.ru>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 02 Aug 2006 20:43:47 +0400
Stas Sergeev <stsp@aknet.ru> wrote:

> Attached is a new espfix cleanup patch.

Ho hum, this conflicts moderately with the hypervisor preparatory patches
which Jeremy sent.

So could I ask that you redo this patch in a couple of weeks time against
the current -mm lineup?  I'd prefer not to merge it immediately because
doing so would make it even harder than usual to work out who to blame if
things break ;)

Thanks.
