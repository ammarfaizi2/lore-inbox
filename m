Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270754AbTG0MJO (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Jul 2003 08:09:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270755AbTG0MJO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Jul 2003 08:09:14 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:19150 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S270754AbTG0MJN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Jul 2003 08:09:13 -0400
Date: Sun, 27 Jul 2003 14:24:17 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
Cc: linux-kernel@vger.kernel.org, trivial@rustcorp.com.au
Subject: Re: [2.6 patch] remove bouncing digilnux list from MAINTAINERS
Message-ID: <20030727122417.GK22218@fs.tum.de>
References: <20030720013251.GB14128@fs.tum.de> <20030720082705.GB25468@wohnheim.fh-wedel.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20030720082705.GB25468@wohnheim.fh-wedel.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 20, 2003 at 10:27:05AM +0200, Jörn Engel wrote:
> On Sun, 20 July 2003 03:32:51 +0200, Adrian Bunk wrote:
> > 
> > The patch below removes a bouncing mailing list for an orphaned driver 
> > from MAINTAINERS.
> > 
> >  W:	http://www.digi.com
> > -L:	digilnux@dgii.com
> 
> Did you try s/dgii/digi/ already?

No, you are right, this address didn't bounce (I got no answer and 
it's listed as orphaned, but at least it didn't bounce...).

Corrected patch below.

> Jörn

cu
Adrian


--- linux-2.6.0-test1-mm2/MAINTAINERS.old	2003-07-27 14:17:29.000000000 +0200
+++ linux-2.6.0-test1-mm2/MAINTAINERS	2003-07-27 14:18:25.000000000 +0200
@@ -572,9 +572,9 @@
 DIGIBOARD PC/XE AND PC/XI DRIVER
 P:	Christoph Lameter
 M:	christoph@lameter.com
 W:	http://www.digi.com
-L:	digilnux@dgii.com
+L:	digilnux@digi.com
 S:	Orphaned
 
 DIRECTORY NOTIFICATION
 P:	Stephen Rothwell
