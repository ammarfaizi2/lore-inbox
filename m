Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262735AbTESSqK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 May 2003 14:46:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262720AbTESSqK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 May 2003 14:46:10 -0400
Received: from nat9.steeleye.com ([65.114.3.137]:16647 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S262718AbTESSqH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 May 2003 14:46:07 -0400
Subject: 2.4 SCSI bug fix tree open
From: James Bottomley <James.Bottomley@steeleye.com>
To: SCSI Mailing List <linux-scsi@vger.kernel.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Cc: marcelo@conectiva.com.br
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-9) 
Date: 19 May 2003 13:58:59 -0500
Message-Id: <1053370740.1826.16.camel@mulgrave>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Several people have complained that 2.4 SCSI bug fixes are getting lost,
so I've opened a bitkeeper tree at

http://linux-scsi.bkbits.net/scsi-misc-2.4

to hold them.

Patches going into this tree should be small, well documented bug fixes
to the current SCSI code (i.e. not driver updates, just bug fixes).

If you want a patch to go in, send it to linux-scsi@vger.kernel.org with
a description of the problem and the fix.

James


