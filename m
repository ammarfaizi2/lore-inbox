Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267087AbUBRXxD (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Feb 2004 18:53:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267101AbUBRXxD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Feb 2004 18:53:03 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:13753 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S267087AbUBRXxA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Feb 2004 18:53:00 -0500
Message-ID: <4033FACA.4010803@pobox.com>
Date: Wed, 18 Feb 2004 18:52:42 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030703
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jochen Friedrich <jochen@scram.de>
CC: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: tms380tr patch 1/3 (bug fix)
References: <Pine.LNX.4.58.0402082342300.1327@localhost>
In-Reply-To: <Pine.LNX.4.58.0402082342300.1327@localhost>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jochen Friedrich wrote:
> diff -u -p -r1.17 tms380tr.c
> --- drivers/net/tokenring/tms380tr.c	7 Feb 2004 03:16:12 -0000	1.17
> +++ drivers/net/tokenring/tms380tr.c	8 Feb 2004 22:24:43 -0000


I am OK with all your patches (especially happy to see firmware go 
away!), but they need to be in the form that scripts can apply them with 
"patch -sp1".  Please resend your 4 patches in this manner.

Thanks,

	Jeff



