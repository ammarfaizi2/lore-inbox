Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265580AbTIDW2y (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Sep 2003 18:28:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265584AbTIDW2x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Sep 2003 18:28:53 -0400
Received: from 168.imtp.Ilyichevsk.Odessa.UA ([195.66.192.168]:2321 "HELO
	127.0.0.1") by vger.kernel.org with SMTP id S265580AbTIDW2w (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Sep 2003 18:28:52 -0400
Content-Type: text/plain; charset=US-ASCII
From: insecure <insecure@mail.od.ua>
Reply-To: insecure@mail.od.ua
To: Michael Frank <mhf@linuxmail.org>, Yann Droneaud <yann.droneaud@mbda.fr>,
       fruhwirth clemens <clemens-dated-1063536166.2852@endorphin.org>
Subject: Re: nasm over gas?
Date: Fri, 5 Sep 2003 01:28:46 +0300
X-Mailer: KMail [version 1.4]
Cc: linux-kernel@vger.kernel.org
References: <20030904104245.GA1823@leto2.endorphin.org> <3F5741BD.5000401@mbda.fr> <200309042257.12739.mhf@linuxmail.org>
In-Reply-To: <200309042257.12739.mhf@linuxmail.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200309050128.47002.insecure@mail.od.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 04 September 2003 17:57, Michael Frank wrote:
> Concur, not worthwhile to start using a fairly unsupported tool in the
> kernel.
>
> As to using assembler, It is better to get rid of it but in special cases.
> Todays compilers are the better coders in 98+% of applications, and if you

Better coders? Show me the evidence.

> follow some of the discussions here on the list, you will be amazed what
> people do with a C compiler - all portable and much more maintainable.

Portable yes. Maintainable yes. Better code _no_.

I'd say compiler generated asm code quality can be anywhere in between of
"hair raising crawling horror" and "not so bad although I can do better".

I have never seen really clever compiler yet. Writing a good compiler
is a very tough thing to do.
-- 
vda
