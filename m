Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270626AbTGURbH (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Jul 2003 13:31:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270627AbTGURal
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Jul 2003 13:30:41 -0400
Received: from 81-5-10-33.aquanet.co.il ([81.5.10.33]:15247 "EHLO localhost")
	by vger.kernel.org with ESMTP id S270722AbTGUR3Q (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Jul 2003 13:29:16 -0400
Message-ID: <3F1C2618.6020702@freed.net>
Date: Mon, 21 Jul 2003 20:42:48 +0300
From: "Sam (Uli) Freed" <sam@freed.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030624
X-Accept-Language: en-us, en, he
MIME-Version: 1.0
To: James Simmons <jsimmons@infradead.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.6-test1 does locks up VGA and keyboard
References: <Pine.LNX.4.44.0307211837460.10689-100000@phoenix.infradead.org>
In-Reply-To: <Pine.LNX.4.44.0307211837460.10689-100000@phoenix.infradead.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

OK, this sounds like something I should try. However, it is night over 
here, so it will wait 'till 2morrow.

Thanks all, will come back later with more news.

Sam

James Simmons wrote:
> Okay. CONFIG_INPUT is modular. This is bad and turns off CONFIG_VT. Please 
> set this to yes. Then turn on CONFIG_VT. After you can go into the Video 
> menu and select what ever console driver you like. Also be careful. You 
> have your keyboard modular as well and this would make typing difficult.
> 
> 
> 
> 

-- 
Sam (Uli) Freed
Tel:    +972 2 652 5072 |   __o     __o      ,__o       o__,
Mobile: +972 54 925 747 |  -\<,   _`\<,_    _-\_<,     ,/_/-_
Email:   sam@freed.net  | O / O  (*)/ (*)  (*)/'(*)   (*)`\(*)

