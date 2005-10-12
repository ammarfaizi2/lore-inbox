Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964806AbVJLPC2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964806AbVJLPC2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Oct 2005 11:02:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964807AbVJLPC1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Oct 2005 11:02:27 -0400
Received: from smtp004.mail.ukl.yahoo.com ([217.12.11.35]:9148 "HELO
	smtp004.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S964806AbVJLPC1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Oct 2005 11:02:27 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.it;
  h=Received:From:To:Subject:Date:User-Agent:Cc:References:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:Content-Disposition:Message-Id;
  b=oZfrWXlt/FdXdkgslMp7EiqhxPlILM63hXYgB8DLmz0DdOTOJ7aokccu4IUP3horT/f0U6l/DvffmnaQPo+Ko8gmBrYfjV5Iljo3hvr58IA1BuBYpxKoUURYQfFdgyaB8YsxMsdUvU/yhFxe8FtJOJfjD42Yl2Hff4Rfvj8prVk=  ;
From: Blaisorblade <blaisorblade@yahoo.it>
To: user-mode-linux-devel@lists.sourceforge.net
Subject: Re: [uml-devel] [PATCH] uml: compile-time fix recent patch
Date: Wed, 12 Oct 2005 17:03:15 +0200
User-Agent: KMail/1.8.2
Cc: Linus Torvalds <torvalds@osdl.org>, Jeff Dike <jdike@addtoit.com>,
       linux-kernel@vger.kernel.org
References: <20051011190101.8637.13495.stgit@zion.home.lan>
In-Reply-To: <20051011190101.8637.13495.stgit@zion.home.lan>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200510121703.16291.blaisorblade@yahoo.it>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 11 October 2005 21:01, Paolo 'Blaisorblade' Giarrusso wrote:
> From: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
>
> Give an empty definition for clear_can_do_skas() when it is not needed.
> Thanks to Junichi Uekawa <dancer@netfort.gr.jp> for reporting the breakage
> and providing a fix (I re-fixed it in an IMHO cleaner way).
>
> Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
Just to make clear, since it hasn't been merged - that's a simple compile fix 
for 2.6.14, so please merge *now*.

The same applies to Jeff's AIO revert patch, it's even much more important. So 
please, at least, don't drop without an answer.
-- 
Inform me of my mistakes, so I can keep imitating Homer Simpson's "Doh!".
Paolo Giarrusso, aka Blaisorblade (Skype ID "PaoloGiarrusso", ICQ 215621894)
http://www.user-mode-linux.org/~blaisorblade

	

	
		
___________________________________ 
Yahoo! Mail: gratis 1GB per i messaggi e allegati da 10MB 
http://mail.yahoo.it
