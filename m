Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266347AbTBCOEF>; Mon, 3 Feb 2003 09:04:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266356AbTBCOEF>; Mon, 3 Feb 2003 09:04:05 -0500
Received: from k101-11.bas1.dbn.dublin.eircom.net ([159.134.101.11]:62470 "EHLO
	corvil.com.") by vger.kernel.org with ESMTP id <S266347AbTBCOEF>;
	Mon, 3 Feb 2003 09:04:05 -0500
Message-ID: <3E3E7841.4090906@Linux.ie>
Date: Mon, 03 Feb 2003 14:10:09 +0000
From: Padraig@Linux.ie
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2) Gecko/20021203
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Martin K. Petersen" <mkp@mkp.net>
CC: Bryan Andersen <bryan@bogonomicon.net>, Pavel Machek <pavel@ucw.cz>,
       kernel list <linux-kernel@vger.kernel.org>
Subject: Re: Compactflash cards dying?
References: <20030202223009.GA344@elf.ucw.cz>	<3E3E1643.2080807@bogonomicon.net> <yq1isw1qwwe.fsf@austin.mkp.net>
In-Reply-To: <yq1isw1qwwe.fsf@austin.mkp.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Bryan> You would be surprised how fast a million writes can happen on
> Bryan> a disk.

especially if you don't mount with noatime.
I mounted my filesystems ro in conjunction with tmpfs
and never had problems with CF.

Pádraig.

