Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262320AbSI1UQ5>; Sat, 28 Sep 2002 16:16:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262321AbSI1UQ5>; Sat, 28 Sep 2002 16:16:57 -0400
Received: from serenity.mcc.ac.uk ([130.88.200.93]:29957 "EHLO
	serenity.mcc.ac.uk") by vger.kernel.org with ESMTP
	id <S262320AbSI1UQ4>; Sat, 28 Sep 2002 16:16:56 -0400
Date: Sat, 28 Sep 2002 21:22:18 +0100
From: John Levon <movement@marcelothewonderpenguin.com>
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fix 2.5.39 floppy driver
Message-ID: <20020928202218.GB59189@compsoc.man.ac.uk>
References: <200209281914.VAA06013@harpo.it.uu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200209281914.VAA06013@harpo.it.uu.se>
User-Agent: Mutt/1.3.25i
X-Url: http://www.movementarian.org/
X-Record: Mr. Scruff - Trouser Jazz
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 28, 2002 at 09:14:04PM +0200, Mikael Pettersson wrote:

>    Fixed by applying Al Viro's O100-get_gendisk-C38 patch.
>    Fixed by applying Al Viro's O101-floppy_sizes-C38 patch.
>    Quick fix: add the missing set_capacity() calls.

Works great for me. Thanks.

regards
john

-- 
"When your name is Winner, that's it. You don't need a nickname."
	- Loser Lane
