Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161165AbWJRPjj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161165AbWJRPjj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Oct 2006 11:39:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161171AbWJRPjj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Oct 2006 11:39:39 -0400
Received: from xenotime.net ([66.160.160.81]:52947 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S1161169AbWJRPji (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Oct 2006 11:39:38 -0400
Date: Wed, 18 Oct 2006 08:41:05 -0700
From: Randy Dunlap <rdunlap@xenotime.net>
To: Jarek Poplawski <jarkao2@o2.pl>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [RFC] DocBook with .txt or .html versions?
Message-Id: <20061018084105.56d61e04.rdunlap@xenotime.net>
In-Reply-To: <20061018114240.GA3202@ff.dom.local>
References: <20061018114240.GA3202@ff.dom.local>
Organization: YPO4
X-Mailer: Sylpheed version 2.2.9 (GTK+ 2.8.10; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 18 Oct 2006 13:42:40 +0200 Jarek Poplawski wrote:

> Is it really so superfluous to have a possibility of 
> reading all docs from Documentation on a lean box
> (e.g. server) without all those xml, flex etc.
> printers' toys installed?

make help ==>

Documentation targets:
  Linux kernel internal documentation in different formats:
  xmldocs (XML DocBook), psdocs (Postscript), pdfdocs (PDF)
  htmldocs (HTML), mandocs (man pages, use installmandocs to install)
                   ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

and 'man 9 yield'
works for me.

or are you saying that you want large *.txt book-like generated files
instead of larger *.html etc?

---
~Randy
