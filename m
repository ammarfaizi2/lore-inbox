Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267231AbSLKRKO>; Wed, 11 Dec 2002 12:10:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267232AbSLKRKO>; Wed, 11 Dec 2002 12:10:14 -0500
Received: from ermelo.utad.pt ([193.136.40.6]:63380 "EHLO marao.utad.pt")
	by vger.kernel.org with ESMTP id <S267231AbSLKRKM>;
	Wed, 11 Dec 2002 12:10:12 -0500
Message-ID: <3DF772B5.5000905@alvie.com>
Date: Wed, 11 Dec 2002 17:15:33 +0000
From: Alvaro Lopes <alvieboy@alvie.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1) Gecko/20020913 Debian/1.1-1
X-Accept-Language: en
MIME-Version: 1.0
To: Brendon Higgins <bh_doc@users.sourceforge.net>
CC: linux-kernel@vger.kernel.org
Subject: Re: PROBLEM: dvd-drive no longer works (2.4.20)
References: <200212051151.59330.bh_doc@users.sourceforge.net> <3DEF7EEC.9040906@alvie.com> <200212061154.20386.bh_doc@users.sourceforge.net> <200212111204.59505.bh_doc@users.sourceforge.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Brendon Higgins wrote:

>hdc: status error: status=0x7f { DriveReady DeviceFault SeekComplete 
>DataRequest CorrectedError Index Error }
>  
>
This looks weird. It's signalling a device fault *and * corrected error. 
Jens ?


