Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262818AbTFKBAY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jun 2003 21:00:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263311AbTFKBAY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jun 2003 21:00:24 -0400
Received: from itaqui.terra.com.br ([200.176.3.19]:16288 "EHLO
	itaqui.terra.com.br") by vger.kernel.org with ESMTP id S262818AbTFKBAV convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jun 2003 21:00:21 -0400
From: Lucas Correia Villa Real <lucasvr@gobolinux.org>
To: madalin mihailescu <madalinn2000@yahoo.com>, linux-kernel@vger.kernel.org
Subject: Re: Help
Date: Tue, 10 Jun 2003 22:14:24 -0300
User-Agent: KMail/1.5.1
References: <20030606055547.51802.qmail@web11003.mail.yahoo.com>
In-Reply-To: <20030606055547.51802.qmail@web11003.mail.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200306102214.24758.lucasvr@gobolinux.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

You can make use of the __setup() macro. A very simple example is given in the 
devfs source code, on the base.c file.

Kind regards,
Lucas


On Friday 06 June 2003 02:55, madalin mihailescu wrote:
> I have a project: implementing four page-out
> alghorythms. I want to be able to select one of them
> at reboot as the first thing I do.
>
> I’m thinking of using a variable, but I don’t know
> where to put it.
>
> 10x
>
> Madalin
>
>
> __________________________________________________
> Yahoo! Plus - For a better Internet experience
> http://uk.promotions.yahoo.com/yplus/yoffer.html
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

