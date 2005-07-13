Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262812AbVGMNLW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262812AbVGMNLW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Jul 2005 09:11:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262673AbVGMNLW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Jul 2005 09:11:22 -0400
Received: from uucp.cistron.nl ([62.216.30.38]:3976 "EHLO ncc1701.cistron.net")
	by vger.kernel.org with ESMTP id S262909AbVGMNLV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Jul 2005 09:11:21 -0400
From: Paul Slootman <paul+nospam@wurtel.net>
Subject: Re: [Hdaps-devel] Re: Updating hard disk firmware & parking hard
 disk
Date: Wed, 13 Jul 2005 13:11:20 +0000 (UTC)
Organization: Wurtelization
Message-ID: <db33tn$bq5$1@news.cistron.nl>
References: <20050707171434.90546.qmail@web32604.mail.mud.yahoo.com> <Pine.LNX.4.61.0507131208540.14635@yvahk01.tjqt.qr> <42D4EB21.1060305@grimmer.com> <Pine.LNX.4.61.0507131259480.14635@yvahk01.tjqt.qr>
X-Trace: ncc1701.cistron.net 1121260280 12101 83.68.3.130 (13 Jul 2005 13:11:20 GMT)
X-Complaints-To: abuse@cistron.nl
X-Newsreader: trn 4.0-test76 (Apr 2, 2001)
To: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jan Engelhardt  <jengelh@linux01.gwdg.de> wrote:
>
>What's the gain in parking the head manually if it's done anyway when the disk 
>spins down (for whatever reason)?

It seems you're completely missing the whole point of this discussion,
which was how to implement the hard disk active protection system that
IBM offers under windows for its laptops, that will park the disk when
it detects that e.g. the laptop is falling off a table.


Paul Slootman

