Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261949AbULVI5J@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261949AbULVI5J (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Dec 2004 03:57:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261951AbULVI5J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Dec 2004 03:57:09 -0500
Received: from einhorn.in-berlin.de ([192.109.42.8]:18327 "EHLO
	einhorn.in-berlin.de") by vger.kernel.org with ESMTP
	id S261949AbULVI47 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Dec 2004 03:56:59 -0500
X-Envelope-From: stefanr@s5r6.in-berlin.de
Message-ID: <41C9370C.1070905@s5r6.in-berlin.de>
Date: Wed, 22 Dec 2004 09:57:48 +0100
From: Stefan Richter <stefanr@s5r6.in-berlin.de>
Reply-To: linux1394-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040914
X-Accept-Language: de, en
MIME-Version: 1.0
To: linux1394-devel@lists.sourceforge.net
CC: linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] ieee1394_core.c: remove unneeded EXPORT_SYMBOL's
References: <20041220015320.GO21288@stusta.de>	 <41C694E0.8010609@informatik.uni-bremen.de>	 <1103544944.4133.7.camel@laptopd505.fenrus.org>	 <20041220132012.GA6046@localhost> <1103704157.4131.5.camel@laptopd505.fenrus.org>
In-Reply-To: <1103704157.4131.5.camel@laptopd505.fenrus.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: (-1.665) AWL,BAYES_00
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arjan van de Ven wrote:
> On Mon, 2004-12-20 at 14:20 +0100, Arne Caspari wrote:
>>>are you going to submit that driver for inclusion any time soon ?
>>What would be the benefit if I do so? 
> you get a lot more eyes on the code; other people help adjusting your
> code to new apis etc etc

...which works best if submitters of patches remember to make use of the 
communication channels suggested in MAINTAINERS.
-- 
Stefan Richter
-=====-=-=-- ==-- =-==-
http://arcgraph.de/sr/
