Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261973AbSLCReM>; Tue, 3 Dec 2002 12:34:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262023AbSLCReM>; Tue, 3 Dec 2002 12:34:12 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:51986 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S261973AbSLCReL>; Tue, 3 Dec 2002 12:34:11 -0500
Message-ID: <3DECECAB.3030308@zytor.com>
Date: Tue, 03 Dec 2002 09:40:59 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3a) Gecko/20021119
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Giacomo Catenazzi <cate@debian.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: Large block device patch, part 1 of 9
References: <fa.l4d1mqv.1ghm1h2@ifi.uio.no> <fa.j8nq6dv.14lihor@ifi.uio.no> <3DEC6F41.9000106@debian.org>
In-Reply-To: <3DEC6F41.9000106@debian.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Giacomo Catenazzi wrote:
> 
> kprintf would be better
 >

Why?  We don't have, say, kstrcpy() or ksscanf() for other functions 
that are library-equivalent.

	-hpa


