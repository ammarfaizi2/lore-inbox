Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264820AbUEMUGY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264820AbUEMUGY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 May 2004 16:06:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264674AbUEMTw5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 May 2004 15:52:57 -0400
Received: from cytosin.uni-konstanz.de ([134.34.240.61]:5373 "EHLO
	cytosin.uni-konstanz.de") by vger.kernel.org with ESMTP
	id S264904AbUEMTuy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 May 2004 15:50:54 -0400
From: Michael Dreher <michael.dreher@uni-konstanz.de>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.6.6-mm2 foibles
Date: Thu, 13 May 2004 21:51:37 +0200
User-Agent: KMail/1.6
References: <200405131442.27573.gene.heskett@verizon.net> <1084475560.1793.0.camel@teapot.felipe-alfaro.com>
In-Reply-To: <1084475560.1793.0.camel@teapot.felipe-alfaro.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200405132151.37423.michael.dreher@uni-konstanz.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Donnerstag, 13. Mai 2004 21:12 schrieb Felipe Alfaro Solana:
> On Thu, 2004-05-13 at 20:42, Gene Heskett wrote:
> > Greetings;
> >
> > I just booted to a 2.6.6-mm2 kernel, and discoverd I had no sound.  So
> > I logged back out of x, and found I had no keyboard!  ssh'd in from
> > the firewall and rebooted it.
> >
> > Both sound, and the backswitch from x were working perfectly up to and
> > including 2.6.6.
>
> I'm also having problems with 2.6.6-mm2 and losing my keyboard. After
> logging into X, after a while, the keyboard stops responding. However,
> my USB mouse still works.

I saw similar thing with 2.6.6 (no -mm), but I can not reproduce it.

IIRC, grepping some binary file triggered it. The grep hung, and keyboard
was dead. Closing the konsole window with mouse gave me my keyboard back.


Michael
