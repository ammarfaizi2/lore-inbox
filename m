Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261879AbUCaJY7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 Mar 2004 04:24:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261899AbUCaJY7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 Mar 2004 04:24:59 -0500
Received: from lindsey.linux-systeme.com ([62.241.33.80]:24583 "EHLO
	mx00.linux-systeme.com") by vger.kernel.org with ESMTP
	id S261879AbUCaJY5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 Mar 2004 04:24:57 -0500
From: Marc-Christian Petersen <m.c.p@wolk-project.de>
Organization: Working Overloaded Linux Kernel
To: linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE] WOLK v2.3 for Kernel v2.6.4
Date: Wed, 31 Mar 2004 11:24:53 +0200
User-Agent: KMail/1.6.1
Cc: Shantanu Goel <sgoel01@yahoo.com>
References: <20040327052132.95751.qmail@web12822.mail.yahoo.com>
In-Reply-To: <20040327052132.95751.qmail@web12822.mail.yahoo.com>
X-Operating-System: Linux 2.6.4-wolk2.3 i686 GNU/Linux
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <200403311124.53874@WOLK>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 27 March 2004 06:21, Shantanu Goel wrote:

Hi Shantanu,

> 1. The kernel oops'ed in vt_ioctl due to driver_data
> being NULL in the tty.  I copied the relevant fix from
> 2.6.5-rc2-mm2.
> 2. I did not configure the in-kernel statd daemon for
> NFS.  That caused a BUG() in mon.c:nsm_monitor()
> because the handle was never initialized.
> 3. A typo fix in ipmi/af_ipmi.c.

thank you :) ... Applied.

ciao, Marc
