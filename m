Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262657AbTEMSmf (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 May 2003 14:42:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263023AbTEMSme
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 May 2003 14:42:34 -0400
Received: from 200-184-71-82.chies.com.br ([200.184.71.82]:16429 "EHLO
	mars.elipse.com.br") by vger.kernel.org with ESMTP id S262657AbTEMSl0
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 May 2003 14:41:26 -0400
Message-ID: <3EC13FA1.4030008@elipse.com.br>
Date: Tue, 13 May 2003 15:55:29 -0300
From: Felipe W Damasio <felipewd@elipse.com.br>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20021226 Debian/1.2.1-9
MIME-Version: 1.0
To: Pawan Deepika <pawan_deepika@yahoo.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: new to network device drivers!!
References: <20030513183746.84104.qmail@web41613.mail.yahoo.com>
In-Reply-To: <20030513183746.84104.qmail@web41613.mail.yahoo.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 13 May 2003 18:55:29.0359 (UTC) FILETIME=[38F56DF0:01C31981]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Pawan Deepika wrote:
>  I am new to device drivers. Can anyone suggest me
> some simple network driver examples(which deal with
> real interface)to start with. What H/W details I need
> to know to write a driver on my own.

	via-rhine is a very simple driver.

	pci-skeleton is also a good place to start playing with.

Felipe

