Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265334AbUAPJe4 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Jan 2004 04:34:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265338AbUAPJe4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Jan 2004 04:34:56 -0500
Received: from imap.gmx.net ([213.165.64.20]:35259 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S265334AbUAPJez (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Jan 2004 04:34:55 -0500
X-Authenticated: #4512188
Message-ID: <4007B03C.4090106@gmx.de>
Date: Fri, 16 Jan 2004 10:34:52 +0100
From: "Prakash K. Cheemplavam" <PrakashKC@gmx.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6b) Gecko/20031208 Thunderbird/0.4
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: 2.6.1-mm4
References: <20040115225948.6b994a48.akpm@osdl.org>
In-Reply-To: <20040115225948.6b994a48.akpm@osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I just gave it a try and the locking-up issue went worse with this 
kernel. Now even without APIC the kernel locks up quite fast on my 
nforce2. Very easy method (for me) was to copy a large file from CD-ROM 
(at least now mounting CDs works again, in contrast to mm2) to HD and 
machine locks-up. Sorry, no stack backtrace yet and no log entry, but 
I'll try to do what I can.

Prakash
