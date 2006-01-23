Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751384AbWAWCZH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751384AbWAWCZH (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Jan 2006 21:25:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751389AbWAWCZH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Jan 2006 21:25:07 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:55507 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1751384AbWAWCZG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Jan 2006 21:25:06 -0500
X-Mailer: exmh version 2.7.0 06/18/2004 with nmh-1.1-RC1
From: Keith Owens <kaos@ocs.com.au>
To: Herbert Xu <herbert@gondor.apana.org.au>
cc: torvalds@osdl.org (Linus Torvalds), bboissin@gmail.com,
       laforge@netfilter.org, xslaby@fi.muni.cz, akpm@osdl.org,
       linux-kernel@vger.kernel.org, davem@davemloft.net
Subject: Re: Iptables error [Was: 2.6.16-rc1-mm2] 
In-reply-to: Your message of "Mon, 23 Jan 2006 13:03:20 +1100."
             <E1F0r3A-0006m2-00@gondolin.me.apana.org.au> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Mon, 23 Jan 2006 13:23:12 +1100
Message-ID: <7380.1137982992@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Herbert Xu (on Mon, 23 Jan 2006 13:03:20 +1100) wrote:
>Linus Torvalds <torvalds@osdl.org> wrote:
>> 
>> Interestingly, __alignof__(unsigned long long) is 8 these days, even 
>> though I think historically on x86 it was 4. Is this perhaps different in 
>> gcc-3 and gcc-4?
>
>gcc 2.95 says 4 while gcc 3.2 says 8.

Has somebody turned on -malign-double in gcc?

