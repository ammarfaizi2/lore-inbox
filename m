Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271082AbTHQUMQ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 17 Aug 2003 16:12:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271090AbTHQUMQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Aug 2003 16:12:16 -0400
Received: from dsl092-053-140.phl1.dsl.speakeasy.net ([66.92.53.140]:38605
	"EHLO grelber.thyrsus.com") by vger.kernel.org with ESMTP
	id S271082AbTHQUMO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Aug 2003 16:12:14 -0400
From: Rob Landley <rob@landley.net>
Reply-To: rob@landley.net
To: linux-kernel@vger.kernel.org
Subject: make htmldocs is broken.
Date: Sun, 17 Aug 2003 06:18:35 -0400
User-Agent: KMail/1.5
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200308170618.35939.rob@landley.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Standard Red Hat 9 install (with 2.6.0-test3-bk1), did a make htmldocs, and it 
barfed like so:

>  DOCPROC Documentation/DocBook/parportbook.sgml
>  FIG2PNG Documentation/DocBook/parport-share.png
>/bin/sh: line 1: fig2dev: command not found
>make[1]: *** [Documentation/DocBook/parport-share.png] Error 127

Does this command live on default installs of SuSE or debian or something?  
(Or maybe it was in RH 7 or so and has been removed?)

Rob

