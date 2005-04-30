Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262510AbVD3FWp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262510AbVD3FWp (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Apr 2005 01:22:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262511AbVD3FWp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Apr 2005 01:22:45 -0400
Received: from fire.osdl.org ([65.172.181.4]:49591 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262510AbVD3FWm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Apr 2005 01:22:42 -0400
Date: Fri, 29 Apr 2005 22:22:01 -0700
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: Karel Kulhavy <clock@twibright.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Which Docbook stylesheets?
Message-Id: <20050429222201.33fe9e6a.rddunlap@osdl.org>
In-Reply-To: <20050421151534.GA13245@beton.cybernet.src>
References: <20050421151534.GA13245@beton.cybernet.src>
Organization: OSDL
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 21 Apr 2005 15:15:34 +0000 Karel Kulhavy wrote:

| kestrel linux-2.6.11.7 # make htmldocs
| *** You need to install DocBook stylesheets ***
| 
| *  app-text/docbook-dsssl-stylesheets
|       Latest version available: 1.77-r2
|       Latest version installed: 1.77-r2
|       Size of downloaded files: 385 kB
|       Homepage:    http://docbook.sourceforge.net
|       Description: DSSSL Stylesheets for DocBook.
|       License:     as-is
| 
| *  app-text/docbook-xsl-stylesheets
|       Latest version available: 1.66.1
|       Latest version installed: 1.66.1
|       Size of downloaded files: 1,514 kB
|       Homepage:    http://docbook.sourceforge.net/
|       Description: XSL Stylesheets for Docbook
|       License:     || ( as-is BSD )
| 
| Which stylesheets?

I could be wrong, but I usually check Documentation/Changes for
this info, which says:

DocBook Stylesheets
-------------------
o  <http://nwalsh.com/docbook/dsssl/>


---
~Randy
