Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261828AbULUStH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261828AbULUStH (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Dec 2004 13:49:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261834AbULUStH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Dec 2004 13:49:07 -0500
Received: from mout.alturo.net ([212.227.15.21]:751 "EHLO mout.alturo.net")
	by vger.kernel.org with ESMTP id S261828AbULUSsv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Dec 2004 13:48:51 -0500
Message-ID: <41C87099.9040108@datafloater.de>
Date: Tue, 21 Dec 2004 19:51:05 +0100
From: Arne Caspari <arne@datafloater.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; de-AT; rv:1.7.2) Gecko/20040820 Debian/1.7.2-4
X-Accept-Language: en
MIME-Version: 1.0
To: Greg KH <greg@kroah.com>
CC: Arne Caspari <arnem@informatik.uni-bremen.de>,
       linux1394-devel@lists.sourceforge.net,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [2.6 patch] ieee1394_core.c: remove unneeded EXPORT_SYMBOL's
References: <20041220015320.GO21288@stusta.de> <41C694E0.8010609@informatik.uni-bremen.de> <20041220143901.GD457@phunnypharm.org> <1103555716.29968.27.camel@localhost.localdomain> <20041220154638.GE457@phunnypharm.org> <1103573716.31512.10.camel@localhost.localdomain> <41C7DFE9.5070604@informatik.uni-bremen.de> <20041221120012.GC5217@stusta.de> <41C81BF4.9070602@datafloater.de> <20041221171547.GD1459@kroah.com>
In-Reply-To: <20041221171547.GD1459@kroah.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH schrieb:

>On Tue, Dec 21, 2004 at 01:49:56PM +0100, Arne Caspari wrote:
>  
>
>>To make a long decision short:
>>
>>There is no stable kernel API that an external developer can rely on?
>>    
>>
>
>That is correct.  Please see Documentation/stable_api_nonsense.txt for
>details as to why this is so.
>
>  
>

There is no such file in the 2.6.9 release :-(

/Arne
