Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314291AbSEIUQh>; Thu, 9 May 2002 16:16:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314294AbSEIUQg>; Thu, 9 May 2002 16:16:36 -0400
Received: from mta01-svc.ntlworld.com ([62.253.162.41]:20727 "EHLO
	mta01-svc.ntlworld.com") by vger.kernel.org with ESMTP
	id <S314291AbSEIUQf>; Thu, 9 May 2002 16:16:35 -0400
Message-ID: <3CDADAF0.4040605@notnowlewis.co.uk>
Date: Thu, 09 May 2002 21:24:16 +0100
From: mikeH <mikeH@notnowlewis.co.uk>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0rc1) Gecko/20020502
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: PANIC , ide related (was lost interrupt hell)
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On the advice of members of this list, I downloaded 2.4.18, patched to 
2.4.19-pre7 installed.

I enabled the via82cxxx option in ide config.

On bootup, just before the partitions are displayed, I get an oops at 
address 00000040, Null pointer dereferenced. Sorry, I was unable to get 
any of the other information it displayed :(

mike

