Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263338AbUEGJAC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263338AbUEGJAC (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 May 2004 05:00:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263375AbUEGJAC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 May 2004 05:00:02 -0400
Received: from indianer.linux-kernel.at ([212.24.125.53]:50920 "EHLO
	indianer.linux-kernel.at") by vger.kernel.org with ESMTP
	id S263338AbUEGI74 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 May 2004 04:59:56 -0400
From: "Oliver Pitzeier" <oliver@linux-kernel.at>
To: "'Christoph Hellwig'" <hch@infradead.org>
Cc: <linux-kernel@vger.kernel.org>
Subject: RE: Strange Linux behaviour!?
Date: Fri, 7 May 2004 11:01:03 +0200
Organization: linux-kernel.at
Message-ID: <013301c43411$d38629d0$d50110ac@sbp.uptime.at>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.3416
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1409
In-Reply-To: <20040507093455.A27829@infradead.org>
Importance: Normal
X-MailScanner-Information-linux-kernel.at: Please contact your Internet E-Mail Service Provider for more information
X-MailScanner-linux-kernel.at: Found to be clean
X-MailScanner-From: oliver@linux-kernel.at
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Fri, May 07, 2004 at 10:33:02AM +0200, Oliver Pitzeier wrote:
> > cd /usr
> > mkdir test
> > mkdir: cannot create directory `test': No space left on device
> 
> ?Have you checked whether you're out of inodes?

No we havn't. After rebooting the machine with 2.6 everything works...
So inodes are not our problem...

Best,
 Oliver

