Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317063AbSHTSxH>; Tue, 20 Aug 2002 14:53:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317102AbSHTSxH>; Tue, 20 Aug 2002 14:53:07 -0400
Received: from mail.gmx.de ([213.165.64.20]:63214 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id <S317063AbSHTSxG>;
	Tue, 20 Aug 2002 14:53:06 -0400
Message-ID: <3D629163.30600@gmx.net>
Date: Tue, 20 Aug 2002 20:58:43 +0200
From: Gunther Mayer <gunther.mayer@gmx.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/20020529
X-Accept-Language: en-us, en
MIME-Version: 1.0
CC: linux-kernel@vger.kernel.org, stp@osdl.org
Subject: Re: IDE?
References: <Pine.LNX.4.10.10208181626580.23171-100000@master.linux-ide.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
To: unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andre Hedrick wrote:

>
>That is how I do it, since I have a code base that has been run over a
>bus analyzer I know it works.
>
It would be interesting to run on a bus simulator to show the driver
behaves correct on all allowed conditions and sensible on error conditions
(i.e. printk and return an error to the application; don't hang the system).


