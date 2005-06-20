Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261466AbVFTS4o@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261466AbVFTS4o (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Jun 2005 14:56:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261463AbVFTSzI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Jun 2005 14:55:08 -0400
Received: from graphe.net ([209.204.138.32]:53214 "EHLO graphe.net")
	by vger.kernel.org with ESMTP id S261467AbVFTSy5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Jun 2005 14:54:57 -0400
Date: Mon, 20 Jun 2005 11:54:52 -0700 (PDT)
From: Christoph Lameter <christoph@lameter.com>
X-X-Sender: christoph@graphe.net
To: Jeff Garzik <jgarzik@pobox.com>
cc: Telemaque Ndizihiwe <telendiz@eircom.net>, torvalds@osdl.org,
       akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Replaces two GOTO statements with one IF_ELSE statement
 in /fs/open.c
In-Reply-To: <42B70E62.5070704@pobox.com>
Message-ID: <Pine.LNX.4.62.0506201154300.2245@graphe.net>
References: <Pine.LNX.4.62.0506201834460.5008@localhost.localdomain>
 <42B70E62.5070704@pobox.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Score: -5.7
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 20 Jun 2005, Jeff Garzik wrote:

> If you don't like goto, don't read kernel code!

But his patch also cleans up a code quit a bit.
