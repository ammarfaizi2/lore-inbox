Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267589AbSLFTos>; Fri, 6 Dec 2002 14:44:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267590AbSLFTos>; Fri, 6 Dec 2002 14:44:48 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:58116 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S267589AbSLFTor>;
	Fri, 6 Dec 2002 14:44:47 -0500
Message-ID: <3DF0FFDA.7040102@pobox.com>
Date: Fri, 06 Dec 2002 14:51:54 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2) Gecko/20021202
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       andre@linux-ide.org, Marcelo Tosatti <marcelo@conectiva.com.br>
Subject: Re: ali15x3 on alpha dies in 2.4.21-BK
References: <3DF00951.1070104@pobox.com> <20021206134434.A2626@jurassic.park.msu.ru>
In-Reply-To: <20021206134434.A2626@jurassic.park.msu.ru>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan, et al.,

Ivan's patch does indeed fix alim15x3 IDE here, for 2.4.21-BK.

(you of course still need the include/asm-alpha/system.h patch I posted, 
too)

