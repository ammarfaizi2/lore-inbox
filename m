Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262314AbTJNJOn (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Oct 2003 05:14:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262327AbTJNJOn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Oct 2003 05:14:43 -0400
Received: from cimice4.lam.cz ([212.71.168.94]:50816 "EHLO beton.cybernet.src")
	by vger.kernel.org with ESMTP id S262314AbTJNJOj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Oct 2003 05:14:39 -0400
Date: Mon, 13 Oct 2003 18:55:39 +0200
From: =?iso-8859-2?Q?Karel_Kulhav=FD?= <clock@twibright.com>
To: linux-kernel@vger.kernel.org
Subject: make htmldocs
Message-ID: <20031013185539.B1832@beton.cybernet.src>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
X-Orientation: Gay
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

root@beton:/usr/src/linux-2.4.22$ make htmldocs
chmod 755 /usr/src/linux-2.4.22/scripts/docgen
chmod 755 /usr/src/linux-2.4.22/scripts/gen-all-syms
chmod 755 /usr/src/linux-2.4.22/scripts/kernel-doc
make -C /usr/src/linux-2.4.22/Documentation/DocBook books
make[1]: Entering directory `/usr/src/linux-2.4.22/Documentation/DocBook'
make[1]: Nothing to be done for `books'.
make[1]: Leaving directory `/usr/src/linux-2.4.22/Documentation/DocBook'
make -C Documentation/DocBook html
make[1]: Entering directory `/usr/src/linux-2.4.22/Documentation/DocBook'
*** You need to install DocBook stylesheets ***
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

1) What is DocBook stylesheets?
2) How do I install DocBook stylesheets?
3) Bugreport: there should be written
"Linux kernel depends on DocBook stylesheets. You may download DocBook
stylesheets here-and-there." in README

Cl<

