Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265678AbUGGXR5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265678AbUGGXR5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jul 2004 19:17:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265681AbUGGXR5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jul 2004 19:17:57 -0400
Received: from mail48.e.nsc.no ([193.213.115.48]:60652 "EHLO mail48.e.nsc.no")
	by vger.kernel.org with ESMTP id S265678AbUGGXRz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jul 2004 19:17:55 -0400
To: tom st denis <tomstdenis@yahoo.com>
Cc: Christoph Hellwig <hch@infradead.org>, Gabriel Paubert <paubert@iram.es>,
       linux-kernel@vger.kernel.org
Subject: Re: 0xdeadbeef vs 0xdeadbeefL
References: <20040707185340.42091.qmail@web41112.mail.yahoo.com>
From: Harald Arnesen <harald@skogtun.org>
Date: Thu, 08 Jul 2004 01:17:36 +0200
In-Reply-To: <20040707185340.42091.qmail@web41112.mail.yahoo.com> (tom st
 denis's message of "Wed, 7 Jul 2004 11:53:40 -0700 (PDT)")
Message-ID: <87iscz9zlb.fsf@basilikum.skogtun.org>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) Emacs/21.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

tom st denis <tomstdenis@yahoo.com> writes:

> Point is 0xDEADBEEFUL is just as simple to type and avoids any sort of
> ambiguitity.  It means unsigned long.  No question about it.  No having
> to refer to subsection 12 of paragraph 15 of section 23 of chapter 9 to
> figure that out.

If people write either 0XdeadbeefUL or 0xDEADBEEFul, fine. But this is a
place where character case really makes a difference in readibility-

> Why people are fighting over this is beyond me.  Fine, write it as
> 0xDEADBEEF see what the hell I care.  Honestly.  Open debate or what?  
>
> And I don't need mr. Viro coming down off his mountain saying "oh you
> fail it" because I don't know some obscure typing rule that I wouldn't
> come accross because *** I AM NOT LAZY ***.  Hey mr. Viro what have you
> contributed to the public domain lately?  Anything I can harp on in
> public and abuse?  

I think you will find that mr. Viro has contributed quite a lot :-)
-- 
Hilsen Harald.
