Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263990AbTHCEBt (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Aug 2003 00:01:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270272AbTHCEBt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Aug 2003 00:01:49 -0400
Received: from evrtwa1-ar2-4-33-045-074.evrtwa1.dsl-verizon.net ([4.33.45.74]:13729
	"EHLO grok.yi.org") by vger.kernel.org with ESMTP id S263990AbTHCEBs
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Aug 2003 00:01:48 -0400
Message-ID: <3F2C891B.7080004@candelatech.com>
Date: Sat, 02 Aug 2003 21:01:31 -0700
From: Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5a) Gecko/20030718
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jeff Garzik <jgarzik@pobox.com>
CC: Nivedita Singhvi <niv@us.ibm.com>,
       Werner Almesberger <werner@almesberger.net>, netdev@oss.sgi.com,
       linux-kernel@vger.kernel.org
Subject: Re: TOE brain dump
References: <20030802140444.E5798@almesberger.net> <3F2BF5C7.90400@us.ibm.com> <3F2C0C44.6020002@pobox.com>
In-Reply-To: <3F2C0C44.6020002@pobox.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik wrote:

> So, fix the other end of the pipeline too, otherwise this fast network 
> stuff is flashly but pointless.  If you want to serve up data from disk, 
> then start creating PCI cards that have both Serial ATA and ethernet 
> connectors on them :)  Cut out the middleman of the host CPU and host 

I for one would love to see something like this, and not just Serial ATA..
but maybe 8x Serial ATA and RAID :)

Ben


-- 
Ben Greear <greearb@candelatech.com>
Candela Technologies Inc  http://www.candelatech.com


