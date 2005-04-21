Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261430AbVDUP2k@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261430AbVDUP2k (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Apr 2005 11:28:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261442AbVDUP2k
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Apr 2005 11:28:40 -0400
Received: from cimice4.lam.cz ([212.71.168.94]:20096 "EHLO beton.cybernet.src")
	by vger.kernel.org with ESMTP id S261430AbVDUP2Z (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Apr 2005 11:28:25 -0400
Date: Thu, 21 Apr 2005 15:30:56 +0000
From: Karel Kulhavy <clock@twibright.com>
To: linux-kernel@vger.kernel.org
Subject: docbook stylesheets complaints when they are installed
Message-ID: <20050421153056.GA13289@beton.cybernet.src>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
X-Orientation: Gay
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

kestrel linux-2.6.11.7 # make htmldocs
*** You need to install DocBook stylesheets ***

*  app-text/docbook-dsssl-stylesheets
      Latest version available: 1.77-r2
      Latest version installed: 1.77-r2
                                ^^^^^^^
      Size of downloaded files: 385 kB
      Homepage:    http://docbook.sourceforge.net
      Description: DSSSL Stylesheets for DocBook.
      License:     as-is

*  app-text/docbook-xsl-stylesheets
      Latest version available: 1.66.1
      Latest version installed: 1.66.1
                                ^^^^^^
      Size of downloaded files: 1,514 kB
      Homepage:    http://docbook.sourceforge.net/
      Description: XSL Stylesheets for Docbook
      License:     || ( as-is BSD )

Is this a symptom of linux kernel mis-detecting
the docbook stylesheets?

CL<
