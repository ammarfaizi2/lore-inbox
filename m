Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261714AbVDTQcL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261714AbVDTQcL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Apr 2005 12:32:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261715AbVDTQcL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Apr 2005 12:32:11 -0400
Received: from einhorn.in-berlin.de ([192.109.42.8]:36061 "EHLO
	einhorn.in-berlin.de") by vger.kernel.org with ESMTP
	id S261714AbVDTQcI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Apr 2005 12:32:08 -0400
X-Envelope-From: stefanr@s5r6.in-berlin.de
Message-ID: <426683E9.4080708@s5r6.in-berlin.de>
Date: Wed, 20 Apr 2005 18:31:37 +0200
From: Stefan Richter <stefanr@s5r6.in-berlin.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040914
X-Accept-Language: de, en
MIME-Version: 1.0
To: linux1394-devel@lists.sourceforge.net
CC: linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] drivers/ieee1394/: remove unneeded EXPORT_SYMBOL's
References: <20050417195706.GD3625@stusta.de>	 <20050419191328.GJ1111@conscoop.ottawa.on.ca>	 <1113939827.6277.86.camel@laptopd505.fenrus.org>	 <42657F7C.8060305@s5r6.in-berlin.de> <1113981989.6238.30.camel@laptopd505.fenrus.org>
In-Reply-To: <1113981989.6238.30.camel@laptopd505.fenrus.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arjan van de Ven wrote:
> On Wed, 2005-04-20 at 00:00 +0200, Stefan Richter wrote:
>>There are users (though not in "the" kernel at the moment)
> nor for the last 5 months... how long will it be ?

Have there been problems with the API during the past 5 months, except 
that several kernel trees are using some parts of the API? (We are 
actually speaking about two APIs of the ieee1394 framework.)

Which problems are solved by this patch? Do they outweigh the problems 
it creates? The latter have been discussed. Dismissing them as Other 
People's Problems does not nullify them.

Where is the agreed-upon, published plan for removal of features in 
ieee1394?
-- 
Stefan Richter
-=====-=-=-= -=-- =-=--
http://arcgraph.de/sr/
