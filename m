Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314525AbSEKPuT>; Sat, 11 May 2002 11:50:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316233AbSEKPuS>; Sat, 11 May 2002 11:50:18 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:32269 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S314525AbSEKPuS>;
	Sat, 11 May 2002 11:50:18 -0400
Message-ID: <3CDD3D76.8030709@mandrakesoft.com>
Date: Sat, 11 May 2002 11:49:10 -0400
From: Jeff Garzik <jgarzik@mandrakesoft.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.9) Gecko/00200203
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Kasper Dupont <kasperd@daimi.au.dk>
CC: Linux-Kernel <linux-kernel@vger.kernel.org>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] Trivial bugfix in 3c509.c
In-Reply-To: <3CDD0D80.E87E4169@daimi.au.dk>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kasper Dupont wrote:

>With 3c509 compiled in kernel calling ifup after lots of
>diskaccess causes an Oops.
>
>read_eeprom was incorrectly marked as __init
>

thanks, will be applied to 2.4 and 2.5




