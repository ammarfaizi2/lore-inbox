Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261417AbTEKXQE (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 May 2003 19:16:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261446AbTEKXQE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 May 2003 19:16:04 -0400
Received: from zinc.btinternet.com ([194.73.73.148]:61332 "EHLO zinc")
	by vger.kernel.org with ESMTP id S261417AbTEKXQD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 May 2003 19:16:03 -0400
Subject: Re: PATCH: Trivial, pedantic spelling mistakes for 2.4.21-rc2
From: Jon Tibble <meths@btinternet.com>
To: Peter Hicks <Peter.Hicks@POGGS.CO.UK>
Cc: jw schultz <jw@pegasys.ws>, linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <3EBE2D24.1030208@POGGS.CO.UK>
References: <3EBDAB7F.4000905@wanadoo.es> <3EBE2436.80504@POGGS.CO.UK>
	 <20030511104229.GE16654@pegasys.ws>  <3EBE2D24.1030208@POGGS.CO.UK>
Content-Type: multipart/mixed; boundary="=-7XmTM5wBINqBL+m171sR"
Organization: 
Message-Id: <1052695680.4770.3.camel@hyperion.rift>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.3 
Date: 12 May 2003 00:28:00 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-7XmTM5wBINqBL+m171sR
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Sun, 2003-05-11 at 11:59, Peter Hicks wrote:
> jw schultz wrote:
> 
> >>Your mailer ate it.  Wordwrap, tab2space and unchanged lines
> >>are missing a leading space.
> >>    
> >>
> I give up, I'm going home!  
> 
> http://journal.poggs.com/2003/05/10/spell-2.4.21rc2.patch
> 
> Its definitely there.  Intact.  Untouched by Mozilla.
> 
Yep, it was there.

The following patch applies on top to fix FIMXME

Jon.

--=-7XmTM5wBINqBL+m171sR
Content-Disposition: attachment; filename=spell_FIXME.patch
Content-Type: text/x-patch; name=spell_FIXME.patch; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

diff -uar linux-2.4.21-rc2/drivers/scsi/cpqfcTSstructs.h linux-2.4.21-rc2-devel/drivers/scsi/cpqfcTSstructs.h
--- linux-2.4.21-rc2/drivers/scsi/cpqfcTSstructs.h	Sun May 11 20:12:38 2003
+++ linux-2.4.21-rc2-devel/drivers/scsi/cpqfcTSstructs.h	Sun May 11 20:13:13 2003
@@ -93,7 +93,7 @@
 #define CPQFCTS_CMD_PER_LUN	15	// power of 2 -1, must be >0
 #define CPQFCTS_REQ_QUEUE_LEN	(TACH_SEST_LEN/2)	// must be < TACH_SEST_LEN
 
-/* FIMXME - these are crap too */
+/* FIXME - these are crap too */
 #define LinuxVersionCode(v, p, s) (((v)<<16)+((p)<<8)+(s))
 #ifndef DECLARE_MUTEX_LOCKED
 #define DECLARE_MUTEX_LOCKED(sem) struct semaphore sem = MUTEX_LOCKED

--=-7XmTM5wBINqBL+m171sR--

