Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261906AbTILUR3 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Sep 2003 16:17:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261837AbTILUQf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Sep 2003 16:16:35 -0400
Received: from smtp12.eresmas.com ([62.81.235.112]:57527 "EHLO
	smtp12.eresmas.com") by vger.kernel.org with ESMTP id S261893AbTILUPS
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Sep 2003 16:15:18 -0400
Message-ID: <3F62294B.2020105@wanadoo.es>
Date: Fri, 12 Sep 2003 22:15:07 +0200
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


