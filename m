Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261228AbTIGRsi (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Sep 2003 13:48:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263376AbTIGRsh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Sep 2003 13:48:37 -0400
Received: from static-ctb-210-9-247-166.webone.com.au ([210.9.247.166]:35598
	"EHLO chimp.local.net") by vger.kernel.org with ESMTP
	id S261228AbTIGRsg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Sep 2003 13:48:36 -0400
Message-ID: <3F5B6F6D.8020002@cyberone.com.au>
Date: Mon, 08 Sep 2003 03:48:29 +1000
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030827 Debian/1.4-3
X-Accept-Language: en
MIME-Version: 1.0
To: Jose Luis Alarcon Sanchez <jlalarcon@chevy.zzn.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Nick's scheduler policy v13
References: <049BFF88F93883E4F94039457A2A2AC3@jlalarcon.chevy.zzn.com>
In-Reply-To: <049BFF88F93883E4F94039457A2A2AC3@jlalarcon.chevy.zzn.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Jose Luis Alarcon Sanchez wrote:

>  Hi Nick.
>
>  I wanna ask you what are the differences beetween your
>"scheduler policy" and "rollup" patches.
>
>  I have installed your last rollup.patch, i must install
>too this scheduler policy version 13? or not?.
>

Hi Jose,
My scheduler policy patches are now just a rollup of a few different
things. Sorry for the confusing naming of the attachments.

This one will replace the last, applying to plain 2.6.0-test4.


