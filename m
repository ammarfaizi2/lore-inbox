Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262303AbTI1CYz (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 27 Sep 2003 22:24:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262304AbTI1CYz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 27 Sep 2003 22:24:55 -0400
Received: from smtp13.eresmas.com ([62.81.235.113]:38286 "EHLO
	smtp13.eresmas.com") by vger.kernel.org with ESMTP id S262303AbTI1CYy
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 27 Sep 2003 22:24:54 -0400
Message-ID: <3F621965.4070106@wanadoo.es>
Date: Fri, 12 Sep 2003 21:07:17 +0200
From: Xose Vazquez Perez <xose@wanadoo.es>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20021003
X-Accept-Language: gl, es, en
MIME-Version: 1.0
To: netdev@oss.sgi.com, linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2.6] pci.ids for e1000
X-Enigmail-Version: 0.63.3.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Score: -1.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik wrote:

> The general idea is to keep 2.4, 2.6, and pciids.sf.net in sync.

is there sync between 2.4, 2.6, and pciids.sf.net ?  ;-)

Linus and Marcelo should not accept patches against pci.ids,
all updates should go to pciids.sf.net. And every X time
to do a sync with 2.4 and 2.6.

It's the easiest, because otherwise is a chaos and it
takes too much work to do several merges:

2.4 <-> 2.6
2.4 <-> pciids
2.4 <-> 2.6

-- 
Que trabajen los romanos, que tienen el pecho de lata.

