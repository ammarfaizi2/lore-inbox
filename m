Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261742AbUK2Pm1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261742AbUK2Pm1 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Nov 2004 10:42:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261738AbUK2Pm1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Nov 2004 10:42:27 -0500
Received: from mx1.redhat.com ([66.187.233.31]:42403 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261736AbUK2Pkm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Nov 2004 10:40:42 -0500
Date: Mon, 29 Nov 2004 10:39:32 -0500 (EST)
From: James Morris <jmorris@redhat.com>
X-X-Sender: jmorris@thoron.boston.redhat.com
To: Adrian Bunk <bunk@stusta.de>
cc: davem@davemloft.net, Jean-Luc Cooke <jlcooke@certainkey.com>,
       Andrew McDonald <andrew@mcdonald.org.uk>,
       Kyle McMartin <kyle@debian.org>, Jean-Francois Dive <jef@linuxbe.org>,
       <linux-kernel@vger.kernel.org>
Subject: Re: [2.6 patch] cry[to/ : make some code static
In-Reply-To: <20041129031636.GS4390@stusta.de>
Message-ID: <Xine.LNX.4.44.0411291039130.6506-100000@thoron.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 29 Nov 2004, Adrian Bunk wrote:

> The patch below makes some needlessly global code static.

Looks fine to me.


- James
-- 
James Morris
<jmorris@redhat.com>


