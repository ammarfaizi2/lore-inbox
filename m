Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262627AbTENBTH (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 May 2003 21:19:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262642AbTENBTH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 May 2003 21:19:07 -0400
Received: from [218.19.173.41] ([218.19.173.41]:260 "EHLO zhangtao.treble.net")
	by vger.kernel.org with ESMTP id S262627AbTENBTF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 May 2003 21:19:05 -0400
Date: Wed, 14 May 2003 09:33:18 +0800
From: zhangtao <zhangtao@zhangtao.org>
To: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Cc: linux-kernel@vger.kernel.org
Subject: Re: About NLS Codepage 932
Message-Id: <20030514093318.0d8d1564.zhangtao@zhangtao.org>
In-Reply-To: <87d6int4qx.fsf@devron.myhome.or.jp>
References: <20030512100534.1ba6ecd6.zhangtao@zhangtao.org>
	<1052737621.31246.7.camel@dhcp22.swansea.linux.org.uk>
	<20030513101740.626a06a5.zhangtao@zhangtao.org>
	<87d6int4qx.fsf@devron.myhome.or.jp>
X-Mailer: Sylpheed version 0.8.11 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 13 May 2003 21:23:18 +0900
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp> wrote:

OK, Thanks!

I want to know how Japanese use these UDC (User defined charactors)? 
I mean, for example, under Japanese version Windows 9x/NT/2000/XP, will the people use these UDC as Filename or others? 
All these UDC have same value, or everyone has different UDC because it's called USER DEFINED?

									zhangtao
									zhangtao@zhangtao.org

> Just FYI,
> 
> zhangtao <zhangtao@zhangtao.org> writes:
> 
> > The big different is the area of Char To Unicode, the lead byte is :
> >   0xF0, 0xF1, 0xF2, 0xF3, 0xF4, 0xF5, 0xF6, 0xF7, 0xF8, 0xF9
> > 
> > In the Microsoft's table (http://www.microsoft.com/globaldev/reference/dbcs/932.htm), they are EMPTY!
> 
> These are UDC (User defined charactors).
> 
> > But in the Mit edu's CP932.TXT (http://web.mit.edu/afs/dev.mit.edu/source/src-current/third/libiconv/tests/CP932.TXT), they have corresponding letters. 
> 
> Looks like using http://www.opengroup.or.jp/jvc/cde/ucs-conv-e.html.
> -- 
> OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
> 
