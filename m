Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262030AbUK3I6F@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262030AbUK3I6F (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Nov 2004 03:58:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262029AbUK3I5l
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Nov 2004 03:57:41 -0500
Received: from psych.st-and.ac.uk ([138.251.11.1]:36789 "EHLO
	psych.st-andrews.ac.uk") by vger.kernel.org with ESMTP
	id S262027AbUK3I5c (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Nov 2004 03:57:32 -0500
Subject: Re: file as a directory
From: Peter Foldiak <Peter.Foldiak@st-andrews.ac.uk>
To: Kevin Fox <Kevin.Fox@pnl.gov>
Cc: Horst von Brand <vonbrand@inf.utfsm.cl>,
       Christian Mayrhuber <christian.mayrhuber@gmx.net>,
       reiserfs-list@namesys.com, Hans Reiser <reiser@namesys.com>,
       Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com>,
       linux-kernel@vger.kernel.org
In-Reply-To: <1101771315.1261.4.camel@zathras.emsl.pnl.gov>
References: <200411292120.iATLKZxE004233@laptop11.inf.utfsm.cl>
	 <41ABA9D3.7020602@st-andrews.ac.uk>
	 <1101771315.1261.4.camel@zathras.emsl.pnl.gov>
Content-Type: text/plain
Message-Id: <1101804850.17807.16.camel@pear.st-and.ac.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.3 
Date: 30 Nov 2004 08:54:10 +0000
Content-Transfer-Encoding: 7bit
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2004-11-29 at 23:35, Kevin Fox wrote:
> Heh. So, you can have a filename that can contain XPath looking junk.
> Now, what happens when you have an XML file that points to another XML
> file using XPath? How do you separate the file name XPath from the XML
> XPath?

My suggestion was simply about unifying the namespace for selection in
the file system and selection within XML files using a syntax related to
(but not necessarily identical with) XPath.
 I was not suggesting you should do anything special with the content of
the XML files, even if the XML file contains an XPath reference.
(The latter could be interesting to think about as a separate issue
later, but it is certainly not part of my simpler suggestion.)
 Peter

