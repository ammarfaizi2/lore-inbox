Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263152AbSJNJZD>; Mon, 14 Oct 2002 05:25:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263155AbSJNJZD>; Mon, 14 Oct 2002 05:25:03 -0400
Received: from k100-128.bas1.dbn.dublin.eircom.net ([159.134.100.128]:59918
	"EHLO corvil.com.") by vger.kernel.org with ESMTP
	id <S263152AbSJNJZC>; Mon, 14 Oct 2002 05:25:02 -0400
Message-ID: <3DAA8E79.70609@corvil.com>
Date: Mon, 14 Oct 2002 10:29:29 +0100
From: Padraig Brady <padraig.brady@corvil.com>
Organization: Corvil Networks
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1) Gecko/20020827
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Wim Van Sebroeck <wim@iguana.be>
CC: linux-kernel@vger.kernel.org
Subject: Re: Watchdog drivers
References: <20021013194041.A15609@medelec.uia.ac.be>
X-Enigmail-Version: 0.65.2.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Wim Van Sebroeck wrote:
> Hi Linus,
> 
> I'm reviewing the different watchdog drivers and started porting the features 
> that have been added in the 2.4 kernel to the 2.5 development kernel.
> I now wondered if it would make sence to put all watchdog drivers in
> drivers/char/watchdog/ instead of in drivers/char ?
> Please comments.

Well I think it's a good idea, as you can easily see what
watchdogs are supported rather than referring to the (currently
out of date) docs:
http://www.cs.helsinki.fi/linux/linux-kernel/2002-02/0713.html

Pádraig.

