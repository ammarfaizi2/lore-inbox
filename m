Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135873AbRDTLjJ>; Fri, 20 Apr 2001 07:39:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135874AbRDTLi7>; Fri, 20 Apr 2001 07:38:59 -0400
Received: from rundog.dialup.access.net ([166.84.201.138]:6984 "EHLO
	sephe.rundog.com") by vger.kernel.org with ESMTP id <S135873AbRDTLit> convert rfc822-to-8bit;
	Fri, 20 Apr 2001 07:38:49 -0400
User-Agent: Microsoft-Entourage/9.0.2509
Date: Fri, 20 Apr 2001 07:38:28 -0400
Subject: Re: Linux 2.4.3 Compile Errors - Power Mac 
From: Jeff Galloway <jeff.galloway@rundog.com>
To: David Woodhouse <dwmw2@infradead.org>
CC: <linux-kernel@vger.kernel.org>
Message-ID: <B70597F4.4264%jeff.galloway@rundog.com>
In-Reply-To: <13993.987753438@redhat.com>
Mime-version: 1.0
Content-type: text/plain; charset="ISO-8859-1"
Content-transfer-encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks.  I'll try your suggestions and check on the version of my compiler
and binutils.

on 4/20/01 3:57 AM, David Woodhouse at dwmw2@infradead.org wrote:

> 
> 
> jeff.galloway@rundog.com said:
>>   However, I don't think that wishing the world would avoid these
>> dominant (and very useful) formats is a realistic expectation.  It is
>> certainly not "common sense" to assume as such.
> 
> Of course it's not a realistic expectation. There are times when it's a pain
> to have to be safe - people will always break the rules when they're in a
> hurry and the document to be sent is already in an unsafe format. But taking
> plain text with absolutely no formatting, in fact text which is
> _degenerated_ by word wrapping &c, and gratuitously putting it in a Word
> document is just _so_ unnecessary that I assumed it had to be a troll.
> 
> 
>> fork.c: In function ?copy_mm:
> 
> Given what this output's been through - I'll assume it's corrupted in
> transit, shall I?
> 
> The kind of error you're seeing is often caused by a mismatch between
> compiler and kernel. As Alan suggests, you should make sure you're using a
> PPC-specific tree because it's not up to date in the stock 2.4.3. And make
> sure you're using the recommended versions of compiler and binutils. Other
> than that, I'm afraid I don't know.
> 
> --
> dwmw2
> 

----------------------------
Jeff Galloway
New York
jeff.galloway@rundog.com


