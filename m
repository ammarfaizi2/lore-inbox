Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262867AbSJGFRf>; Mon, 7 Oct 2002 01:17:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262869AbSJGFRf>; Mon, 7 Oct 2002 01:17:35 -0400
Received: from orion.netbank.com.br ([200.203.199.90]:60679 "EHLO
	orion.netbank.com.br") by vger.kernel.org with ESMTP
	id <S262867AbSJGFRe>; Mon, 7 Oct 2002 01:17:34 -0400
Date: Mon, 7 Oct 2002 02:22:55 -0300
From: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
To: Bart Trojanowski <bart@jukie.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [2.4.19] fix for fuzzy hash <linux/ghash.h> [Attempt 2]
Message-ID: <20021007052255.GG1201@conectiva.com.br>
Mail-Followup-To: Arnaldo Carvalho de Melo <acme@conectiva.com.br>,
	Bart Trojanowski <bart@jukie.net>, linux-kernel@vger.kernel.org
References: <20021006170124.D28201@jukie.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021006170124.D28201@jukie.net>
User-Agent: Mutt/1.4i
X-Url: http://advogato.org/person/acme
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Em Sun, Oct 06, 2002 at 05:01:24PM -0400, Bart Trojanowski escreveu:
> wonder no one has spotted it.  The patch is very trivial and makes me
> think that I am the very first user of the include/linux/ghash.h
> hash-table primitive.   ;)

Somebody told me that this was used in when dentry was introduced to the
kernel, but then after rewrites it stopped being used, I was even thinking
about submitting a patch removing it from the tree, but now there is one user,
you :-)

- Arnaldo
