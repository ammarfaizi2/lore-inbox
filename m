Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261191AbTCSXG5>; Wed, 19 Mar 2003 18:06:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261211AbTCSXG5>; Wed, 19 Mar 2003 18:06:57 -0500
Received: from static-b3-12.highspeed.eol.ca ([64.56.235.12]:39951 "EHLO
	TMA-1.brad-x.com") by vger.kernel.org with ESMTP id <S261191AbTCSXGx>;
	Wed, 19 Mar 2003 18:06:53 -0500
Message-ID: <3E78FA9C.3000707@brad-x.com>
Date: Wed, 19 Mar 2003 18:17:48 -0500
From: Brad Laue <brad@brad-x.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20030223
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Stuart MacDonald <stuartm@connecttech.com>
Cc: Andrus Nomm <a.nomm@wap3.net>, linux-kernel@vger.kernel.org
Subject: Re: Kernels 2.2 and 2.4 exploit (ALL VERSION WHAT I HAVE TESTED UNTILL
 NOW!) - removed link
References: <000701c2ee22$efe61fd0$0100a8c0@andrus> <01f001c2ee5b$f418dd20$294b82ce@connecttech.com>
In-Reply-To: <01f001c2ee5b$f418dd20$294b82ce@connecttech.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Stuart MacDonald wrote:

>The irony is that the bug reporting process makes the bug public, so
>you would've had the same result.
>
>..Stu
>  
>
My problem is with the fix for 2.4.x; last I checked, XFree86 et al 
should not be surrounded by square brackets, such as is the case now:

brad      1625  0.0  0.5  3080 1448 ?        S    17:16   0:01 [fam]
root      1942  2.2 16.7 308692 42896 ?      S    17:16   1:21 [X]
brad      1968  0.0  0.6  3644 1720 ?        S    17:17   0:00 
[xscreensaver]

etc.

-- 
// -- http://www.BRAD-X.com/ -- //


