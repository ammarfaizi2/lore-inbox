Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261694AbVDSWRq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261694AbVDSWRq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Apr 2005 18:17:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261695AbVDSWRq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Apr 2005 18:17:46 -0400
Received: from hp3.statik.TU-Cottbus.De ([141.43.120.68]:58641 "EHLO
	statik.tu-cottbus.de") by vger.kernel.org with ESMTP
	id S261694AbVDSWRo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Apr 2005 18:17:44 -0400
Message-ID: <42657F7C.8060305@s5r6.in-berlin.de>
Date: Wed, 20 Apr 2005 00:00:28 +0200
From: Stefan Richter <stefanr@s5r6.in-berlin.de>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.7.2) Gecko/20040803
X-Accept-Language: de, en
MIME-Version: 1.0
To: linux1394-devel@lists.sourceforge.net
CC: linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] drivers/ieee1394/: remove unneeded EXPORT_SYMBOL's
References: <20050417195706.GD3625@stusta.de>	 <20050419191328.GJ1111@conscoop.ottawa.on.ca> <1113939827.6277.86.camel@laptopd505.fenrus.org>
In-Reply-To: <1113939827.6277.86.camel@laptopd505.fenrus.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arjan van de Ven wrote:
> On Tue, 2005-04-19 at 15:13 -0400, Jody McIntyre wrote:
>> On Sun, Apr 17, 2005 at 09:57:07PM +0200, Adrian Bunk wrote:
>> > This patch removes unneeded EXPORT_SYMBOL's.
...
>> Given the objections to your December patch, why should we accept this
>> one now?
> 
> since there still isn't a user ??

There are users (though not in "the" kernel at the moment), have been
users, will be users.

Note: There is no architectural problem or something like that which
would be a reason to change the API.
-- 
Stefan Richter
-=====-=-=-= --== -===-
http://arcgraph.de/sr/
