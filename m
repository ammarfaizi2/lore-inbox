Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263588AbUDFBsu (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Apr 2004 21:48:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263591AbUDFBst
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Apr 2004 21:48:49 -0400
Received: from smtp018.mail.yahoo.com ([216.136.174.115]:34956 "HELO
	smtp018.mail.yahoo.com") by vger.kernel.org with SMTP
	id S263588AbUDFBs1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Apr 2004 21:48:27 -0400
Message-ID: <40720C68.1050102@yahoo.com.au>
Date: Tue, 06 Apr 2004 11:48:24 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040122 Debian/1.6-1
X-Accept-Language: en
MIME-Version: 1.0
To: Pavel Machek <pavel@ucw.cz>
CC: Rusty trivial patch monkey Russell <trivial@rustcorp.com.au>,
       Andrew Morton <akpm@zip.com.au>,
       kernel list <linux-kernel@vger.kernel.org>
Subject: Re: Telling user machine is going to crash at KERN_WARNING level
 is good joke
References: <20040405210717.GA3558@elf.ucw.cz>
In-Reply-To: <20040405210717.GA3558@elf.ucw.cz>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek wrote:
> Hi!
> 
> ...but its victims might not like it. Please apply,

Hmm I get this message on a 16-way NUMAQ with 16GB RAM and
it doesn't crash. Well it was unstable recently, but that
seems to have gone away now.
