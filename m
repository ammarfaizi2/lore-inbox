Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030208AbWCWIR1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030208AbWCWIR1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Mar 2006 03:17:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030207AbWCWIR1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Mar 2006 03:17:27 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:31421 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1030206AbWCWIR0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Mar 2006 03:17:26 -0500
Subject: Re: [2.6.16 PATCH] Connector: Filesystem Events Connector
From: Arjan van de Ven <arjan@infradead.org>
To: Yi Yang <yang.y.yi@gmail.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>
In-Reply-To: <44216612.3060406@gmail.com>
References: <44216612.3060406@gmail.com>
Content-Type: text/plain
Date: Thu, 23 Mar 2006 09:17:24 +0100
Message-Id: <1143101844.3147.9.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-03-22 at 22:58 +0800, Yi Yang wrote:
> This patch implements a new connector, Filesystem Event Connector,
>  the user can monitor filesystem activities via it, currently, it
>  can monitor access, attribute change, open, create, modify, delete,
>  move and close of any file or directory.


how is this not redundant functionality with the audit subsystem ?


