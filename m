Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262418AbVCXFdM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262418AbVCXFdM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Mar 2005 00:33:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263038AbVCXFdM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Mar 2005 00:33:12 -0500
Received: from graphe.net ([209.204.138.32]:36105 "EHLO graphe.net")
	by vger.kernel.org with ESMTP id S262418AbVCXFdI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Mar 2005 00:33:08 -0500
Date: Wed, 23 Mar 2005 21:32:54 -0800 (PST)
From: Christoph Lameter <christoph@lameter.com>
X-X-Sender: christoph@server.graphe.net
To: "Randy.Dunlap" <rddunlap@osdl.org>
cc: Adrian Bunk <bunk@stusta.de>, Andrew Morton <akpm@osdl.org>,
       Tina Yang <tinay@chelsio.com>, Scott Bardone <sbardone@chelsio.com>,
       linux-kernel@vger.kernel.org, jgarzik@pobox.com,
       linux-net@vger.kernel.org
Subject: Re: [-mm patch] drivers/net/chelsio/osdep.h: small cleanups
In-Reply-To: <42424ECB.4060807@osdl.org>
Message-ID: <Pine.LNX.4.58.0503232131570.13007@server.graphe.net>
References: <20050321025159.1cabd62e.akpm@osdl.org> <20050324031026.GV1948@stusta.de>
 <Pine.LNX.4.58.0503231934430.11120@server.graphe.net> <42424ECB.4060807@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Score: -5.9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 23 Mar 2005, Randy.Dunlap wrote:

> Christoph Lameter wrote:
> > We just send an update to Andrew and Jeff that also fixes this issue.
> > Sadly that patch is >300k so we cannot post it to the list.
>
> you can post it to netdev@oss.sgi.com
> it doesn't seem to block large patches.

Ok. Sent in a separate message. I avoided ccing anyone on
this to cut down the mail volume.

