Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262157AbSJIXqH>; Wed, 9 Oct 2002 19:46:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262210AbSJIXqH>; Wed, 9 Oct 2002 19:46:07 -0400
Received: from mail019.syd.optusnet.com.au ([210.49.20.160]:36055 "EHLO
	mail019.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id <S262157AbSJIXqG>; Wed, 9 Oct 2002 19:46:06 -0400
Message-ID: <3DA4C07C.3040306@bigpond.com>
Date: Thu, 10 Oct 2002 09:49:16 +1000
From: Brendan J Simon <brendan.simon@bigpond.com>
Reply-To: brendan.simon@bigpond.com
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.1) Gecko/20020826
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Sam Ravnborg <sam@ravnborg.org>
CC: Linus Torvalds <torvalds@transmeta.com>,
       Roman Zippel <zippel@linux-m68k.org>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       kbuild-devel <kbuild-devel@lists.sourceforge.net>
Subject: Re: [kbuild-devel] Re: linux kernel conf 0.8
References: <20021009191600.A1708@mars.ravnborg.org> <Pine.LNX.4.44.0210091033200.7355-100000@home.transmeta.com> <20021009195531.B1708@mars.ravnborg.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sam Ravnborg wrote:

>So I would suggest:
>
>Config.conf		<= Main entry in any directory
>sensible-name.conf	<= Any group of related files
>
>ls *.conf 	list all configuration files.
>ls rrunner*	list all files spcific for rrunner
>

I really like this.  It's just so intuative :)

Brendan Simon.


