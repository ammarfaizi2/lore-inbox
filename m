Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262075AbSJDTtW>; Fri, 4 Oct 2002 15:49:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262077AbSJDTtW>; Fri, 4 Oct 2002 15:49:22 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:58378 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S262075AbSJDTtV>;
	Fri, 4 Oct 2002 15:49:21 -0400
Message-ID: <3D9DF1EB.8040807@pobox.com>
Date: Fri, 04 Oct 2002 15:54:19 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1) Gecko/20020826
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Denis Zaitsev <zzz@cd-club.ru>
CC: davej@suse.de, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [TRIVIAL] 2.5.40 de2104x: a lots of timer messages
References: <20021004225051.B346@natasha.zzz.zzz>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Denis Zaitsev wrote:
> This patch fixes a lots of annoying timer messages for this ethernet
> adapter.  Please, apply it.


If the messages annoy you, disable that bit using ethtool.  It's not 
necessary to hack the driver for this.

