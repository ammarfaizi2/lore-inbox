Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262332AbSJISbx>; Wed, 9 Oct 2002 14:31:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262361AbSJISbj>; Wed, 9 Oct 2002 14:31:39 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:34312 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S262332AbSJISa0>;
	Wed, 9 Oct 2002 14:30:26 -0400
Message-ID: <3DA47709.30606@pobox.com>
Date: Wed, 09 Oct 2002 14:35:53 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1) Gecko/20020826
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: Sam Ravnborg <sam@ravnborg.org>, Roman Zippel <zippel@linux-m68k.org>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       kbuild-devel <kbuild-devel@lists.sourceforge.net>
Subject: Re: linux kernel conf 0.8
References: <Pine.LNX.4.44.0210091033200.7355-100000@home.transmeta.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> So instead: how about just "Config" for the main per-directory
> configuration file, with sub-config's being "Config.3c5xx" and
> "Config.rrunner".


I like it.  I'm glad Sam mentioned sub-configs such as Config.3c5xx, 
that's something that was discussed a while ago [and apparently we all 
forgot about it subsequently :)]

And the above eliminates my criticism of having "Config.in" be two 
different config languages, depending on your kernel version.

	Jeff



