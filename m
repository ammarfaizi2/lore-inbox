Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261437AbVBGOfY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261437AbVBGOfY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Feb 2005 09:35:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261444AbVBGOei
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Feb 2005 09:34:38 -0500
Received: from smtp8.wanadoo.fr ([193.252.22.23]:18330 "EHLO smtp8.wanadoo.fr")
	by vger.kernel.org with ESMTP id S261432AbVBGObt convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Feb 2005 09:31:49 -0500
X-ME-UUID: 20050207143146268.416E31C00208@mwinf0802.wanadoo.fr
Subject: Re: Re: Reading Bad DVD Under 2.6.10 freezes the box.
From: Xavier Bestel <xavier.bestel@free.fr>
To: Justin Piszcz <jpiszcz@lucidpixels.com>
Cc: linux-os@analogic.com, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.62.0502070914230.8764@p500>
References: <Pine.LNX.4.62.0502070728520.1743@p500>
	 <Pine.LNX.4.61.0502070757580.21063@chaos.analogic.com>
	 <1107783980.6191.154.camel@gonzales>
	 <Pine.LNX.4.62.0502070914230.8764@p500>
Content-Type: text/plain; charset=utf-8
Date: Mon, 07 Feb 2005 15:25:38 +0100
Message-Id: <1107786338.6191.159.camel@gonzales>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-3) 
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Le lundi 07 février 2005 à 09:17 -0500, Justin Piszcz a écrit :
> Yeah, I can try 2.4.29 later tonight; also, the DVD is not scratched, just 
> formatted with Joilet/ISO instead of UDF (which is what should be used on 
> DVDs).
> 
> However, dd if=/dev/hdh of=file.img
>           Even with bs=1 for 1 byte at a time, there seems to be no way to
>           get the data off, however...
> 
>           With the dd, last time I tried it, it just fails.
>           When I use cp to try and copy the file, it freezes the machine.

Does it work with ide-scsi ?

	Xav


