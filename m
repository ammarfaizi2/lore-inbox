Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316592AbSGCD2S>; Tue, 2 Jul 2002 23:28:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316786AbSGCD2R>; Tue, 2 Jul 2002 23:28:17 -0400
Received: from mtiwmhc23.worldnet.att.net ([204.127.131.48]:64429 "EHLO
	mtiwmhc23.worldnet.att.net") by vger.kernel.org with ESMTP
	id <S316592AbSGCD2Q>; Tue, 2 Jul 2002 23:28:16 -0400
Date: Tue, 2 Jul 2002 23:35:38 -0400
To: Andrew Morton <akpm@zip.com.au>
Cc: linux-kernel@vger.kernel.org, ext3-users@redhat.com
Subject: Re: sync slowness. ext3 on VIA vt82c686b
Message-ID: <20020703033538.GA3004@lnuxlab.ath.cx>
References: <20020703022051.GA2669@lnuxlab.ath.cx> <3D226E86.695D27F3@zip.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3D226E86.695D27F3@zip.com.au>
User-Agent: Mutt/1.3.28i
From: khromy@lnuxlab.ath.cx (khromy)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 02, 2002 at 08:24:54PM -0700, Andrew Morton wrote:
>khromy wrote:
>> 
>>When I copy a file(13Megs) from /home/ to /tmp/, sync takes almost 2 minutes.
>>When I copy the same file to /usr/local/, sync returns almost right away.
>
>Gad.  Please, mount those filesystems as ext2 and retest.

I just did, same exact behavior.. Anything else?

-- 
L1:	khromy		;khromy(at)lnuxlab.ath.cx
