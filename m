Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317081AbSGNUYe>; Sun, 14 Jul 2002 16:24:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317083AbSGNUYd>; Sun, 14 Jul 2002 16:24:33 -0400
Received: from esteel10.client.dti.net ([209.73.14.10]:18629 "EHLO
	shookay.newview.com") by vger.kernel.org with ESMTP
	id <S317081AbSGNUYc>; Sun, 14 Jul 2002 16:24:32 -0400
To: linux-kernel@vger.kernel.org
Subject: Re: IDE/ATAPI in 2.5
References: <200207142004.g6EK4LaV019433@burner.fokus.gmd.de>
	<xltznwujc0u.fsf@shookay.newview.com>
From: Mathieu Chouquet-Stringer <mathieu@newview.com>
Date: 14 Jul 2002 16:27:18 -0400
In-Reply-To: <xltznwujc0u.fsf@shookay.newview.com>
Message-ID: <xltvg7ijbrt.fsf@shookay.newview.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

mathieu@newview.com (Mathieu Chouquet-Stringer) writes:
> I'm running tar (the regular version not star) right now on an Athlon @
> 850. The fs is ext3 and the disk is a scsi drive.
> So far, tar has been running for 17 min 25 sec, and that's what top says:
> CPU states:  1.7% user, 98.2% system,  0.0% nice,  0.0% idle
> 
> (FYI, nothing else is taking some large amount of cpu time)
> 
> So I would say Joerg is right... :-(

BTW my kernel is 2.4.18 vanilla. I'll keep you posted when it's done.

-- 
Mathieu Chouquet-Stringer              E-Mail : mathieu@newview.com
    It is exactly because a man cannot do a thing that he is a
                      proper judge of it.
                      -- Oscar Wilde
