Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261959AbUCONNh (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Mar 2004 08:13:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262562AbUCONNg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Mar 2004 08:13:36 -0500
Received: from lindsey.linux-systeme.com ([62.241.33.80]:6153 "EHLO
	mx00.linux-systeme.com") by vger.kernel.org with ESMTP
	id S261959AbUCONNf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Mar 2004 08:13:35 -0500
From: Marc-Christian Petersen <m.c.p@wolk-project.de>
Organization: Working Overloaded Linux Kernel
To: linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE] WOLK v2.0 for Kernel v2.6.4
Date: Mon, 15 Mar 2004 14:13:13 +0100
User-Agent: KMail/1.6.1
Cc: wolk-devel@lists.sourceforge.net, wolk-announce@lists.sourceforge.net
References: <200403142314.37398@WOLK>
In-Reply-To: <200403142314.37398@WOLK>
X-Operating-System: Linux 2.4.20-wolk4.10s i686 GNU/Linux
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200403151413.13643@WOLK>
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 14 March 2004 23:14, Marc-Christian Petersen wrote:

Hi again,

> o   added:    Allow reading last block (write not)		(Andrea Arcangeli)

my bad, this should be:


 o    fixed:    reading the last block on a bdev		(Chris Mason)


it is this fix: 
http://linux.bkbits.net:8080/linux-2.5/cset@1.1608.83.55?nav=index.html|
ChangeSet@-7d


Thanks to Jens for noticing this.

ciao, Marc
