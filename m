Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263844AbTDUMgQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Apr 2003 08:36:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263845AbTDUMgQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Apr 2003 08:36:16 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:61656
	"EHLO lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S263844AbTDUMgP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Apr 2003 08:36:15 -0400
Subject: Re: Are linux-fs's drive-fault-tolerant by concept?
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Stephan von Krawczynski <skraw@ithnet.com>
Cc: John Bradford <john@grabjohn.com>, josh@stack.nl,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20030421132409.4636a001.skraw@ithnet.com>
References: <20030421113236.3955d5e6.skraw@ithnet.com>
	 <200304210955.h3L9tCVx000292@81-2-122-30.bradfords.org.uk>
	 <20030421132409.4636a001.skraw@ithnet.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1050925806.13040.0.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 21 Apr 2003 12:50:07 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Llu, 2003-04-21 at 12:24, Stephan von Krawczynski wrote:
> On Mon, 21 Apr 2003 10:55:12 +0100 (BST)
> John Bradford <john@grabjohn.com> wrote:
> 
> 
> > > And again, how do you think this should work out on your _root_
> > > partition? (see below)
> > 
> > 1. Hot plug a new disk
> 
> On Linux IDE ??
> 
> Are you sure?

I wouldn't recommend it on any IDE unless your controller has the right
features *AND* someone bothered to wire them. Even then you'll need
some user apps to handle the isolation etc


