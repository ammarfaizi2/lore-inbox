Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291388AbSBMF5J>; Wed, 13 Feb 2002 00:57:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291390AbSBMF47>; Wed, 13 Feb 2002 00:56:59 -0500
Received: from angband.namesys.com ([212.16.7.85]:50562 "HELO
	angband.namesys.com") by vger.kernel.org with SMTP
	id <S291388AbSBMF4y>; Wed, 13 Feb 2002 00:56:54 -0500
Date: Wed, 13 Feb 2002 08:56:53 +0300
From: Oleg Drokin <green@namesys.com>
To: Luigi Genoni <kernel@Expansa.sns.it>
Cc: Alex Riesen <fork0@users.sourceforge.net>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [reiserfs-dev] 2.5.4-pre1: zero-filled files reiserfs
Message-ID: <20020213085653.A5957@namesys.com>
In-Reply-To: <20020212200124.A2267@namesys.com> <Pine.LNX.4.44.0202121807120.15720-100000@Expansa.sns.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0202121807120.15720-100000@Expansa.sns.it>
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On Tue, Feb 12, 2002 at 06:13:18PM +0100, Luigi Genoni wrote:

> I run slackware 8.0.49, and there was no log replaying.
Ok.

> The corruption is the one we are talking about since some days,
> file are fille of 0s instead of their supposed content.
Hm. Was that a plain reboot?
Did you tried to run reiserfsck --rebuild-tree between reboots before
finding files with zeroes.
(if you did, that may somewhat explain what you've seen)

> I usually restore corrupted file, so I should keep one fopr you, I think.
Ok, if it became all zeroes, then I do not need it.

Bye,
    Oleg
