Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262315AbTJNJOk (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Oct 2003 05:14:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262319AbTJNJOk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Oct 2003 05:14:40 -0400
Received: from cimice4.lam.cz ([212.71.168.94]:50560 "EHLO beton.cybernet.src")
	by vger.kernel.org with ESMTP id S262315AbTJNJOj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Oct 2003 05:14:39 -0400
Date: Mon, 13 Oct 2003 18:53:04 +0200
From: =?iso-8859-2?Q?Karel_Kulhav=FD?= <clock@twibright.com>
To: linux-kernel@vger.kernel.org
Subject: README bugreport
Message-ID: <20031013185304.A1832@beton.cybernet.src>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
X-Orientation: Gay
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"
 - The Documentation/DocBook/ subdirectory contains several guides for
   kernel developers and users.  These guides can be rendered in a
   number of formats:  PostScript (.ps), PDF, and HTML, among others.
   After installation, "make psdocs", "make pdfdocs", or "make htmldocs"
   will render the documentation in the requested format.
"

root@beton:/usr/src/linux-2.4.22/Documentation$ make htmldocs
make: *** No rule to make target `htmldocs'.  Stop.

Shall read: ""make htmldocs" [...] in toplevel Linux kernel source directory will
render the documentation in the requested format"

Cl<

