Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263085AbUEWPii@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263085AbUEWPii (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 23 May 2004 11:38:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263089AbUEWPih
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 23 May 2004 11:38:37 -0400
Received: from ptb-relay01.plus.net ([212.159.14.212]:39693 "EHLO
	ptb-relay01.plus.net") by vger.kernel.org with ESMTP
	id S263085AbUEWPif (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 23 May 2004 11:38:35 -0400
Message-ID: <40B0C56A.1050701@mauve.plus.com>
Date: Sun, 23 May 2004 16:38:18 +0100
From: Ian Stirling <ian.stirling@mauve.plus.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6b) Gecko/20031210
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Greg KH <greg@kroah.com>
CC: Arjan van de Ven <arjanv@redhat.com>, Linus Torvalds <torvalds@osdl.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [RFD] Explicitly documenting patch submission
References: <Pine.LNX.4.58.0405222341380.18601@ppc970.osdl.org> <1085299337.2781.5.camel@laptop.fenrus.com> <20040523152540.GA5518@kroah.com>
In-Reply-To: <20040523152540.GA5518@kroah.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH wrote:
> On Sun, May 23, 2004 at 10:02:17AM +0200, Arjan van de Ven wrote:
> 
>>On Sun, 2004-05-23 at 08:46, Linus Torvalds wrote:
>>
>>>Hola!
>>>
>>>This is a request for discussion..
>>
>>Can we make this somewhat less cumbersome even by say, allowing
>>developers to file a gpg key and sign a certificate saying "all patches
>>that I sign with that key are hereby under this regime". I know you hate
>>it but the FSF copyright assignment stuff at least has such "do it once
>>for forever" mechanism making the pain optionally only once.
> 
> 
> I don't think that adding a single line to ever patch description is
> really "pain".  Especially compared to the FSF proceedure :)
> 
> Also, gpg signed patches are a pain to handle on the maintainer's side
> of things, speaking from personal experience.  However our patch


Has anyone ever tried to forge the name on a patch, and get it included?
