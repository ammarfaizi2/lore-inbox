Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131654AbRCSX6l>; Mon, 19 Mar 2001 18:58:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131665AbRCSX6b>; Mon, 19 Mar 2001 18:58:31 -0500
Received: from perninha.conectiva.com.br ([200.250.58.156]:9477 "HELO
	postfix.conectiva.com.br") by vger.kernel.org with SMTP
	id <S131654AbRCSX6S>; Mon, 19 Mar 2001 18:58:18 -0500
Date: Mon, 19 Mar 2001 19:13:28 -0300 (BRT)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
To: David Raufeisen <david@fortyoz.org>
Cc: linux-kernel@vger.kernel.org, reiserfs-list@namesys.com
Subject: Re: 2.4.3-pre1 oops w/ rsync & ReiserFS
In-Reply-To: <20010319152842.A11014@fortyoz.org>
Message-ID: <Pine.LNX.4.21.0103191912460.8220-100000@freak.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 19 Mar 2001, David Raufeisen wrote:

> Getting oops every time I run rsync today.. happens after it receives file list and is starting to stat all the files.. filesystem is reiser.
> 
> Linux prototype 2.4.3-pre1 #2 Thu Mar 15 00:24:43 PST 2001 i686 unknown
> 
> 15:25:28 up 1 day, 20:05,  4 users,  load average: 0.00, 0.03, 0.00
> 
> Linux prototype 2.4.3-pre1 #2 Thu Mar 15 00:24:43 PST 2001 i686 unknown

David,

Can you please use "memtest86" to check if your RAM does not have
problems? 

