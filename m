Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964974AbWEaMMn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964974AbWEaMMn (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 May 2006 08:12:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964980AbWEaMMn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 May 2006 08:12:43 -0400
Received: from embla.aitel.hist.no ([158.38.50.22]:18104 "HELO
	embla.aitel.hist.no") by vger.kernel.org with SMTP id S964974AbWEaMMm
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 May 2006 08:12:42 -0400
Message-ID: <447D878C.8090907@aitel.hist.no>
Date: Wed, 31 May 2006 14:09:48 +0200
From: Helge Hafting <helge.hafting@aitel.hist.no>
User-Agent: Thunderbird 1.5.0.2 (X11/20060516)
MIME-Version: 1.0
To: Martin Mares <mj@ucw.cz>
CC: Jon Smirl <jonsmirl@gmail.com>, Ondrej Zajicek <santiago@mail.cz>,
       linux-kernel@vger.kernel.org
Subject: Re: OpenGL-based framebuffer concepts
References: <20060519224056.37429.qmail@web26611.mail.ukl.yahoo.com> <200605272245.22320.dhazelton@enter.net> <9e4733910605272027o7b59ea5n5d402dabdd7167cb@mail.gmail.com> <200605280112.01639.dhazelton@enter.net> <21d7e9970605281613y3c44095bu116a84a66f5ba1d7@mail.gmail.com> <9e4733910605281759j2e7bebe1h6e3f2bf1bdc3fc50@mail.gmail.com> <Pine.LNX.4.63.0605301033330.4786@qynat.qvtvafvgr.pbz> <20060530223513.GA32267@localhost.localdomain> <9e4733910605301555o287cbd18i99c8813ca6592494@mail.gmail.com> <mj+md-20060531.064701.10737.atrey@ucw.cz>
In-Reply-To: <mj+md-20060531.064701.10737.atrey@ucw.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Martin Mares wrote:
> Hi!
>
>   
>> My thoughts are mixed on continuing to support text mode for anything
>> other than initial boot/install. Linux is all about multiple languages
>> and the character ROMs for text mode don't support all of these
>> languages.
>>     
>
> On most servers, you don't need (and you don't want) anything like that.
> In such cases, everything should be kept simple.
Linux isn't all about servers - but still, a framebuffer is not
"complicated" compared to vga textmode.  It uses more
memory, but that is graphichs memory the server can't
put to better use anyway.


Helge Hafting
