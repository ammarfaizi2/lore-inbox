Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751007AbWEWKqA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751007AbWEWKqA (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 May 2006 06:46:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751164AbWEWKqA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 May 2006 06:46:00 -0400
Received: from smtp108.mail.mud.yahoo.com ([209.191.85.218]:20139 "HELO
	smtp108.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1751007AbWEWKqA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 May 2006 06:46:00 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=y4sOQgDQYK91mnqglRh1TMv1k7NQzC65Qvn6ai98j3de6aD1UYp9XxkHxDyiSAhQqwBeHz8W1KHNEFNqYdhav2pN56l2KD6sVG4wtiaLSdZCRCDRCevI9CymQG5iw9LGd9bF8xfMsqFUl0IsPdQBAIkDsA1SKd5ycFrtARkMtsA=  ;
Message-ID: <4472E7E4.6060403@yahoo.com.au>
Date: Tue, 23 May 2006 20:45:56 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: =?ISO-8859-1?Q?Haar_J=E1nos?= <djani22@netcenter.hu>
CC: kernel@kolivas.org, cw@f00f.org, linux-kernel@vger.kernel.org
Subject: Re: swapper: page allocation failure. - random reboot problem
References: <00e901c67cad$fe9a9d90$1800a8c0@dcccs> <200605222117.27433.kernel@kolivas.org> <031001c67db1$a8c4a1e0$1800a8c0@dcccs> <200605230112.45564.kernel@kolivas.org> <047401c67de3$a05a52c0$1800a8c0@dcccs> <4472D327.3060808@yahoo.com.au> <013601c67e51$eef03c10$1800a8c0@dcccs> <4472E2E0.4000201@yahoo.com.au> <018401c67e54$1043cfb0$1800a8c0@dcccs>
In-Reply-To: <018401c67e54$1043cfb0$1800a8c0@dcccs>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Haar János wrote:
> ----- Original Message ----- 

>>But is the power supply rated enough to support all the drives?
>>I have seen random reboots where the power supply wasn't good
>>enough.
> 
> 
> This is the 3rd modell, currently 550W.
> The system is P4 3G.
> 
> The another 2 stable node uses only 460W, and all hardware is equal.
> But i tried to swap ps between the stable and unstabe nodes, but nothing is
> changed....

Not sure then, sorry.

If it is a software problem, then if you can narrow it down further
(eg. kernel 2.6.15 worked, 2.6.16 did not), or find a reproducable
test case for it, then some more progress might be made.

-- 
SUSE Labs, Novell Inc.
Send instant messages to your online friends http://au.messenger.yahoo.com 
