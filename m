Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263736AbUDUAYL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263736AbUDUAYL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Apr 2004 20:24:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264269AbUDUAYL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Apr 2004 20:24:11 -0400
Received: from crete.csd.uch.gr ([147.52.16.2]:34813 "EHLO crete.csd.uch.gr")
	by vger.kernel.org with ESMTP id S263736AbUDUAYJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Apr 2004 20:24:09 -0400
Organization: 
Date: Wed, 21 Apr 2004 03:23:58 +0300 (EEST)
From: Panagiotis Papadakos <papadako@csd.uoc.gr>
To: Panagiotis Papadakos <papadako@csd.uoc.gr>
cc: "Randy.Dunlap" <rddunlap@osdl.org>,
       "Giacomo A. Catenazzi" <cate@debian.org>, linux-kernel@vger.kernel.org
Subject: Re: Compile error in main.c [2.6.bk]
In-Reply-To: <Pine.GSO.4.58.0404200236250.948@thanatos.csd.uoc.gr>
Message-ID: <Pine.GSO.4.58.0404210322350.912@pegasus.csd.uch.gr>
References: <407F821A.3040908@debian.org> <20040418040111.GR3445@bakeyournoodle.com>
 <40836E12.8000402@debian.org> <20040419092155.1614862a.rddunlap@osdl.org>
 <40840565.6000304@debian.org> <20040419101743.3c50e14b.rddunlap@osdl.org>
 <Pine.GSO.4.58.0404200236250.948@thanatos.csd.uoc.gr>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Flag: NO
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Well you should run "bk -r co -q" in the cloned tree you use to
build the kernel, since audit.h is a new file!

	Panagiotis Papadakos

