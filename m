Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282468AbRKZT4X>; Mon, 26 Nov 2001 14:56:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282459AbRKZTzE>; Mon, 26 Nov 2001 14:55:04 -0500
Received: from e33.co.us.ibm.com ([32.97.110.131]:4554 "EHLO
	e33.bld.us.ibm.com") by vger.kernel.org with ESMTP
	id <S282456AbRKZTxo>; Mon, 26 Nov 2001 14:53:44 -0500
Message-ID: <3C029DCA.7080200@us.ibm.com>
Date: Mon, 26 Nov 2001 11:53:46 -0800
From: "David C. Hansen" <haveblue@us.ibm.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.5+) Gecko/20011110
X-Accept-Language: en-us
MIME-Version: 1.0
To: Flavio Stanchina <flavio.stanchina@tin.it>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Remove needless BKL from release functions
In-Reply-To: <200111231047.fANAlA105874@ns.caldera.de> <3C028008.6000605@us.ibm.com> <20011126194153.MIQN11444.fep23-svc.tin.it@there>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Flavio Stanchina wrote:

>Look closer, it doesn't check 'handler' (it couldn't).
>
Silly me... Thanks.


