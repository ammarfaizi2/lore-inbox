Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267934AbUH0IQR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267934AbUH0IQR (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Aug 2004 04:16:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268215AbUH0IOF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Aug 2004 04:14:05 -0400
Received: from rwcrmhc12.comcast.net ([216.148.227.85]:5850 "EHLO
	rwcrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S267934AbUH0INl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Aug 2004 04:13:41 -0400
Message-ID: <412EED36.3080802@namesys.com>
Date: Fri, 27 Aug 2004 01:13:42 -0700
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040803
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jeremy Allison <jra@samba.org>
CC: Andrew Morton <akpm@osdl.org>, Spam <spam@tnonline.net>, wichert@wiggy.net,
       torvalds@osdl.org, hch@lst.de, linux-fsdevel@vger.kernel.org,
       linux-kernel@vger.kernel.org, flx@namesys.com,
       reiserfs-list@namesys.com
Subject: Re: silent semantic changes with reiser4
References: <412CEE38.1080707@namesys.com> <20040825152805.45a1ce64.akpm@osdl.org> <112698263.20040826005146@tnonline.net> <Pine.LNX.4.58.0408251555070.17766@ppc970.osdl.org> <1453698131.20040826011935@tnonline.net> <20040825163225.4441cfdd.akpm@osdl.org> <20040825233739.GP10907@legion.cup.hp.com> <20040825234629.GF2612@wiggy.net> <1939276887.20040826114028@tnonline.net> <20040826024956.08b66b46.akpm@osdl.org> <20040826173227.GB1570@legion.cup.hp.com>
In-Reply-To: <20040826173227.GB1570@legion.cup.hp.com>
X-Enigmail-Version: 0.85.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I think Jeremy is accurate in saying the below.

Jeremy Allison wrote:

>>What compelling reason is there for doing this in the kernel?
>>    
>>
>
>
>Because without kernel support there is no way someone can
>publish a new metadata type and have it automatically supported
>by all application data files (ie. most apps ignore it, and only
>apps that are aware of it can see it). Without kernel support
>you have to have all apps agree on a data format. And
>that's harder to do than getting linux kernel VFS engineers
>to agree on things :-).
>
>Jeremy.
>
>
>  
>

