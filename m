Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265800AbSKYXFR>; Mon, 25 Nov 2002 18:05:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265815AbSKYXFQ>; Mon, 25 Nov 2002 18:05:16 -0500
Received: from c3po.aoltw.net ([64.236.137.25]:44191 "EHLO netscape.com")
	by vger.kernel.org with ESMTP id <S265800AbSKYXFJ>;
	Mon, 25 Nov 2002 18:05:09 -0500
Message-ID: <3DE2AE4C.6070904@netscape.com>
Date: Mon, 25 Nov 2002 15:12:12 -0800
From: jgmyers@netscape.com (John Myers)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.2) Gecko/20021121
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Davide Libenzi <davidel@xmailserver.org>
CC: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [rfc] new poll callback'd wake up hell ...
References: <3DE29EB9.9050301@netscape.com> <Pine.LNX.4.50.0211251433200.1793-100000@blue1.dev.mcafeelabs.com>
In-Reply-To: <Pine.LNX.4.50.0211251433200.1793-100000@blue1.dev.mcafeelabs.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Davide Libenzi wrote:

>No, look at the code :
>  
>
Ok, I completely misread what you wrote.  I thought you were suggestiong 
a change to the locking behavior of wake_up() itself.

One wonders if a work-to-do would be appropriate.


