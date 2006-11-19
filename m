Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932685AbWKSSIf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932685AbWKSSIf (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Nov 2006 13:08:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932693AbWKSSIf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Nov 2006 13:08:35 -0500
Received: from einhorn.in-berlin.de ([192.109.42.8]:55741 "EHLO
	einhorn.in-berlin.de") by vger.kernel.org with ESMTP
	id S932685AbWKSSIe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Nov 2006 13:08:34 -0500
X-Envelope-From: stefanr@s5r6.in-berlin.de
Message-ID: <45609D74.8070201@s5r6.in-berlin.de>
Date: Sun, 19 Nov 2006 19:07:48 +0100
From: Stefan Richter <stefanr@s5r6.in-berlin.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.0.6) Gecko/20060730 SeaMonkey/1.0.4
MIME-Version: 1.0
To: Gene Heskett <gene.heskett@verizon.net>
CC: linux-kernel@vger.kernel.org, Mattia Dongili <malattia@linux.it>,
       Greg KH <greg@kroah.com>, Andrew Morton <akpm@osdl.org>,
       linux1394-devel@lists.sourceforge.net, bcollins@debian.org
Subject: Kino segfault (was Re: ohci1394 oops bisected)
References: <455CAE0F.1080502@s5r6.in-berlin.de> <455F7EDD.6060007@s5r6.in-berlin.de> <20061119162220.GA2536@inferi.kami.home> <200611191214.32647.gene.heskett@verizon.net>
In-Reply-To: <200611191214.32647.gene.heskett@verizon.net>
X-Enigmail-Version: 0.94.1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Gene Heskett wrote:
> If this has anything to do with kino segfaulting and going away when 
> trying to make use of the on-screen camera motion controls, please see to 
> it that it gets incorporated into the next FC6 kernel release, its badly 
> needed for us ieee1394 users.

No, it's very probably unrelated. You could report Kino related bugs via
www.kinodv.org --- or on bugzilla.redhat.com if it's merely an issue
with the distributed versions of Kino/ libraries/ kernel.
-- 
Stefan Richter
-=====-=-==- =-== =--==
http://arcgraph.de/sr/
