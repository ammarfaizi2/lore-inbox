Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270631AbTGURdh (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Jul 2003 13:33:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270608AbTGURbW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Jul 2003 13:31:22 -0400
Received: from 81-5-10-33.aquanet.co.il ([81.5.10.33]:14735 "EHLO localhost")
	by vger.kernel.org with ESMTP id S270667AbTGUR3F (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Jul 2003 13:29:05 -0400
Message-ID: <3F1C25BC.8050203@freed.net>
Date: Mon, 21 Jul 2003 20:41:16 +0300
From: "Sam (Uli) Freed" <sam@freed.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030624
X-Accept-Language: en-us, en, he
MIME-Version: 1.0
To: "Robert P. J. Day" <rpjday@mindspring.com>
CC: James Simmons <jsimmons@infradead.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.6-test1 does locks up VGA and keyboard
References: <Pine.LNX.4.44.0307211817060.10689-100000@phoenix.infradead.org> <3F1C21C3.4000901@freed.net> <Pine.LNX.4.53.0307211336340.3076@localhost.localdomain>
In-Reply-To: <Pine.LNX.4.53.0307211336340.3076@localhost.localdomain>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Could well be, but I don't think it explains the VGA sizeing up.... 
Also, no problems on 2.4...

Robert P. J. Day wrote:
> On Mon, 21 Jul 2003, Sam (Uli) Freed wrote:
> 
> 
>>Sorry, I did something like menuconfig using the old 2.4 and then make 
>>bzImage etc. Here is the .config from the 2.6 dir, attached.
> 
> 
> is there a reason that you configured your mouse and keyboard as
> modules, rather than building them into the kernel?  might this
> be a possible problem?
> 
> rday
> 
> 

-- 
Sam (Uli) Freed
Tel:    +972 2 652 5072 |   __o     __o      ,__o       o__,
Mobile: +972 54 925 747 |  -\<,   _`\<,_    _-\_<,     ,/_/-_
Email:   sam@freed.net  | O / O  (*)/ (*)  (*)/'(*)   (*)`\(*)

