Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270711AbTG0KXu (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Jul 2003 06:23:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270720AbTG0KXu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Jul 2003 06:23:50 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:38787
	"EHLO lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S270711AbTG0KXt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Jul 2003 06:23:49 -0400
Subject: Re: snap support in linux
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: D Qi <dqi@freenet.co.uk>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <3F23A25A.3050708@freenet.co.uk>
References: <3F23A25A.3050708@freenet.co.uk>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1059302111.12759.0.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 27 Jul 2003 11:35:12 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sul, 2003-07-27 at 10:58, D Qi wrote:
> Is this a issue for the network setting of the running Linux box or some 
> thing else? Does SNAP frame work by default or is there some thing need 
> to be done at the driver level? Please help.

SNAP and IPX over SNAP were working last time I checked. IP over SNAP is
not supported unless someone added it without me noticing

