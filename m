Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261207AbULWLJO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261207AbULWLJO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Dec 2004 06:09:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261208AbULWLJO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Dec 2004 06:09:14 -0500
Received: from keetweej.xs4all.nl ([213.84.46.114]:32700 "EHLO
	keetweej.vanheusden.com") by vger.kernel.org with ESMTP
	id S261207AbULWLJL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Dec 2004 06:09:11 -0500
Date: Thu, 23 Dec 2004 12:09:10 +0100 (CET)
From: Folkert van Heusden <folkert@vanheusden.com>
X-X-Sender: <folkert@muur.intranet.vanheusden.com>
To: <linux-kernel@vger.kernel.org>
Subject: pc stalling when processing large files [2.6.9]
Message-ID: <Pine.LNX.4.33.0412231205470.28376-100000@muur.intranet.vanheusden.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I have a P-III with 384MB of ram running kernel 2.6.9. It has one IDE disk.
When processing a large mailbox with sa-learn (the bayes learn tool of
spamassassin), the system gets very unresponsive. Like: when typing commands
on it via ssh, the system doesn't respond several times for seconds (1 or 2
maybe 3). Then when I continue to type, it gets a little better but when
idling for say 10 seconds it gets unresponsive again. The large mailbox is
aprox 200MB.
My .config can be found at: http://keetweej.vanheusden.com/~folkert/config


Folkert van Heusden

Op zoek naar een IT of Finance baan? Mail me voor de mogelijkheden!
+------------------------------------------------------------------+
|UNIX admin? Then give MultiTail (http://vanheusden.com/multitail/)|
|a try, it brings monitoring logfiles to a different level! See    |
|http://vanheusden.com/multitail/features.html for a feature list. |
+------------------------------------------= www.unixsoftware.nl =-+

