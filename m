Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263024AbUELWxc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263024AbUELWxc (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 May 2004 18:53:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263032AbUELWxc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 May 2004 18:53:32 -0400
Received: from pixpat.austin.ibm.com ([192.35.232.241]:53754 "EHLO
	falcon10.austin.ibm.com") by vger.kernel.org with ESMTP
	id S263024AbUELWxa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 May 2004 18:53:30 -0400
Message-Id: <200405122253.i4CMrR31014078@falcon10.austin.ibm.com>
X-Mailer: exmh version 2.6.3 04/04/2003 with nmh-1.0.4
To: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
cc: linux-kernel@vger.kernel.org
Subject: Re: ppc64 HDIO_TASK_* ioctls 2.4, 2.6 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Wed, 12 May 2004 17:53:27 -0500
From: Doug Maxey <dwm@austin.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 13 May 2004 00:47:49 +0200, Bartlomiej Zolnierkiewicz wrote:
>  HDIO_DRIVE_TASK is _always_ available 

Yes, indeed.  Move the line, or eliminate the conditionals entirely?

++doug


