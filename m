Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261524AbVCKTz7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261524AbVCKTz7 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Mar 2005 14:55:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261318AbVCKTyz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Mar 2005 14:54:55 -0500
Received: from 209-204-138-32.dsl.static.sonic.net ([209.204.138.32]:37639
	"EHLO graphe.net") by vger.kernel.org with ESMTP id S261403AbVCKTwH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Mar 2005 14:52:07 -0500
Date: Fri, 11 Mar 2005 11:51:56 -0800 (PST)
From: Christoph Lameter <christoph@lameter.com>
X-X-Sender: christoph@server.graphe.net
To: Andrew Morton <akpm@osdl.org>
cc: linux-kernel@vger.kernel.org, mark@chelsio.com, netdev@oss.sgi.com,
       Jeff Garzik <jgarzik@pobox.com>
Subject: Re: A new 10GB Ethernet Driver by Chelsio Communications
In-Reply-To: <20050311112132.6a3a3b49.akpm@osdl.org>
Message-ID: <Pine.LNX.4.58.0503111151190.24786@server.graphe.net>
References: <Pine.LNX.4.58.0503110356340.14213@server.graphe.net>
 <20050311112132.6a3a3b49.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Score: -5.9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 11 Mar 2005, Andrew Morton wrote:

> > It supports AMD64, EM64T and x86 systems.
>
> Is it only supported on those systems?  If so, why is that?

The driver was only tested on those architectures.
