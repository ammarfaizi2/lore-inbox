Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268778AbTCAQZi>; Sat, 1 Mar 2003 11:25:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268809AbTCAQZi>; Sat, 1 Mar 2003 11:25:38 -0500
Received: from wohnheim.fh-wedel.de ([195.37.86.122]:41404 "EHLO
	wohnheim.fh-wedel.de") by vger.kernel.org with ESMTP
	id <S268778AbTCAQZh>; Sat, 1 Mar 2003 11:25:37 -0500
Date: Sat, 1 Mar 2003 17:35:55 +0100
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: shaheed <srhaque@iee.org>
Cc: ms@citd.de, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kernel source spellchecker
Message-ID: <20030301163555.GA1379@wohnheim.fh-wedel.de>
References: <200303011557.13691.srhaque@iee.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <200303011557.13691.srhaque@iee.org>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 1 March 2003 15:57:13 +0000, shaheed wrote:
> 
> Here is a list of corrections...I have omitted those that seem OK to me, 
> apostrophes, proper names, some that seem to be hypenation-related, American 
> vs. British differences and a few others.
> 
> In the case of broken American spelling, I have provided American fixes 
> (against my better judgement :-)). Enjoy...
> 
> brain-damaged=dain-bramaged,dain bramaged

What's wrong with those? Yes, they don't exist in a dictionary, but
neither do a 
c
o
rner or d-a-s-h-i-n-g or the famous
   p              z
 y r a   and    i g g
m i d s       u r a t s

I don't know where art starts and whether kernel documentation is a
decent place for it, but a second thought might be worth it. :)

btw: man fortune | grep redundancy -C2

Jörn, bringing the comedian back

-- 
Fantasy is more important than knowlegde. Knowlegde is limited,
while fantasy embraces the whole world.
-- Albert Einstein
