Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267694AbTASVt5>; Sun, 19 Jan 2003 16:49:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267696AbTASVt5>; Sun, 19 Jan 2003 16:49:57 -0500
Received: from adsl-67-114-19-186.dsl.pltn13.pacbell.net ([67.114.19.186]:53155
	"HELO adsl-63-202-77-221.dsl.snfc21.pacbell.net") by vger.kernel.org
	with SMTP id <S267694AbTASVt4>; Sun, 19 Jan 2003 16:49:56 -0500
Message-ID: <3E2B1F9E.8030105@tupshin.com>
Date: Sun, 19 Jan 2003 13:58:54 -0800
From: Tupshin Harper <tupshin@tupshin.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20021226 Debian/1.2.1-9
X-Accept-Language: en
MIME-Version: 1.0
To: Andre Hedrick <andre@linux-ide.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.4.21-pre3-ac oops
References: <Pine.LNX.4.10.10301191327050.12087-100000@master.linux-ide.org>
In-Reply-To: <Pine.LNX.4.10.10301191327050.12087-100000@master.linux-ide.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andre Hedrick wrote:

>Exactly when you want to flush the devices to platter.
>The problem will be what to do if we get an error on flush-cache.
>
>Andre Hedrick
>LAD Storage Consulting Group
>
>On Sun, 19 Jan 2003, Bryan Andersen wrote:
>
>  
>
Are these "no cach flush required" messages going to be removed? It does 
clutter up the boot process output pretty badly.

-Tupshin

