Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264374AbUAZTEa (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jan 2004 14:04:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264433AbUAZTE3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jan 2004 14:04:29 -0500
Received: from slask.tomt.net ([217.8.136.223]:56037 "EHLO pelle.tomt.net")
	by vger.kernel.org with ESMTP id S264374AbUAZTE2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jan 2004 14:04:28 -0500
Message-ID: <401564BA.4080805@tomt.net>
Date: Mon, 26 Jan 2004 20:04:26 +0100
From: Andre Tomt <andre@tomt.net>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.6b) Gecko/20031205 Thunderbird/0.4
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Cc: campbell@accelinc.com
Subject: Re: 2.2 kernel and ext3 filesystems
References: <20040124033208.GA4830@helium.inexs.com> <20040123215848.28dac746.akpm@osdl.org> <20040126145633.GA26983@helium.inexs.com>
In-Reply-To: <20040126145633.GA26983@helium.inexs.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chuck Campbell wrote:
>>It was written for 2.2, and then forward-ported.
          ^^^^^^
> Interesting.  I looked at the system running 2.2, and there are no ext3
> options in the running config file.  It may have been later than 2.2.22...

"written for" is not the same as "included in" ;-)

> All of this made me remember that an ext3 filesystem can be mounted as ext2, 
> so I got done what I really needed anyway.

Good :-)
