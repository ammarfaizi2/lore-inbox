Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269926AbRIHP4f>; Sat, 8 Sep 2001 11:56:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269967AbRIHP4Z>; Sat, 8 Sep 2001 11:56:25 -0400
Received: from cpe-24-221-152-185.az.sprintbbd.net ([24.221.152.185]:22400
	"EHLO opus.bloom.county") by vger.kernel.org with ESMTP
	id <S269926AbRIHP4O>; Sat, 8 Sep 2001 11:56:14 -0400
Date: Sat, 8 Sep 2001 08:56:06 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Andrew Morton <akpm@zip.com.au>, lkml <linux-kernel@vger.kernel.org>,
        "ext3-users@redhat.com" <ext3-users@redhat.com>
Subject: Re: ext3-2.4-0.9.9
Message-ID: <20010908085606.D635@cpe-24-221-152-185.az.sprintbbd.net>
In-Reply-To: <3B991346.7393E7AF@zip.com.au> <20010908045952.P7672@emma1.emma.line.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20010908045952.P7672@emma1.emma.line.org>
User-Agent: Mutt/1.3.20i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 08, 2001 at 04:59:52AM +0200, Matthias Andree wrote:
> On Fri, 07 Sep 2001, Andrew Morton wrote:
> 
> > Patches against 2.4.10-pre4 and 2.4.9-ac9 are at
> 
> One issue about 0.9.6, 0.9.9 shows no relevant changes: can I mount my
> root partition with data=journal without setting up an initrd?

If you pass rootflags=data=journal, yes.  I _think_ that's the flag.

-- 
Tom Rini (TR1265)
http://gate.crashing.org/~trini/
