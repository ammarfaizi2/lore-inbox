Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946202AbWJSQbK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946202AbWJSQbK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Oct 2006 12:31:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946200AbWJSQbK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Oct 2006 12:31:10 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:4758 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1946202AbWJSQbH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Oct 2006 12:31:07 -0400
Subject: Re: [2.6.19 patch] drivers/ide/pci/generic.c: re-add the
	__setup("all-generic-ide",...)
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Adrian Bunk <bunk@stusta.de>
Cc: Randy Dunlap <randy.dunlap@oracle.com>, Alan Cox <alan@redhat.com>,
       Patrick Jefferson <henj@hp.com>, Kenny Graunke <kenny@whitecape.org>,
       linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org
In-Reply-To: <20061019161338.GT3502@stusta.de>
References: <Pine.LNX.4.64.0610130941550.3952@g5.osdl.org>
	 <20061017155934.GC3502@stusta.de> <4534C7A7.7000607@hp.com>
	 <20061018221520.GK3502@stusta.de>
	 <20061018231844.GA16857@devserv.devel.redhat.com>
	 <20061019152651.GR3502@stusta.de>
	 <20061019090741.853ea100.randy.dunlap@oracle.com>
	 <20061019161338.GT3502@stusta.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Thu, 19 Oct 2006 17:29:58 +0100
Message-Id: <1161275398.17335.87.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Iau, 2006-10-19 am 18:13 +0200, ysgrifennodd Adrian Bunk:
> > Missing update to Documentation/kernel-parameters.txt ?
> > (maybe it's been missing forever?)
> 
> It's been missing forever.
> 
> I'm not sure whether documenting it now where it's deprecated and nearly 
> dead makes sense..

Its not dead, its so useful that drivers/ata also supports it

