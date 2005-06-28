Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262302AbVF1XsP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262302AbVF1XsP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Jun 2005 19:48:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262300AbVF1Xq3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Jun 2005 19:46:29 -0400
Received: from simmts12.bellnexxia.net ([206.47.199.141]:22462 "EHLO
	simmts12-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id S262289AbVF1Xho (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Jun 2005 19:37:44 -0400
Message-ID: <1765.10.10.10.24.1120001856.squirrel@linux1>
In-Reply-To: <40A9C7C2-1AFE-45BC-90A5-571628304479@mac.com>
References: <42B9E536.60704@pobox.com> <20050623235634.GC14426@waste.org>
    <20050624064101.GB14292@pasky.ji.cz>
    <20050624123819.GD9519@64m.dyndns.org>
    <20050628150027.GB1275@pasky.ji.cz> <20050628180157.GI12006@waste.org>
    <62CF578B-B9DF-4DEA-8BAD-041F357771FD@mac.com>
    <3886.10.10.10.24.1119991512.squirrel@linux1>
    <20050628221422.GT12006@waste.org>
    <3993.10.10.10.24.1119997389.squirrel@linux1>
    <20050628224946.GU12006@waste.org>
    <4846.10.10.10.24.1119999568.squirrel@linux1>
    <40A9C7C2-1AFE-45BC-90A5-571628304479@mac.com>
Date: Tue, 28 Jun 2005 19:37:36 -0400 (EDT)
Subject: Re: Mercurial vs Updated git HOWTO for kernel hackers
From: "Sean" <seanlkml@sympatico.ca>
To: "Kyle Moffett" <mrmacman_g4@mac.com>
Cc: "Matt Mackall" <mpm@selenic.com>, "Petr Baudis" <pasky@ucw.cz>,
       "Christopher Li" <hg@chrisli.org>, "Jeff Garzik" <jgarzik@pobox.com>,
       "Linux Kernel" <linux-kernel@vger.kernel.org>,
       "Git Mailing List" <git@vger.kernel.org>, mercurial@selenic.com
User-Agent: SquirrelMail/1.4.4-2
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Priority: 3 (Normal)
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, June 28, 2005 7:25 pm, Kyle Moffett said:
> On Jun 28, 2005, at 18:59:28, Sean wrote:
>> By the sounds of it, git could just use Mecurial or some variation
>> thereof
>> as a back end.
>
> Umm, you seem to miss the point, sir.  If you use Mercurial, there is no
> reason you should layer any part of Git on top of it.  It already does
> everything that git does anyways.

No, you seem to miss the point.  Git already does everything Mercurial
does, and does it pretty well too.  The _point_ was that if the big
"feature" of Mercurial is it's on disk format, Git is perfectly capable of
copying it at any point.   The on disk format just ISN'T CLOSE TO BEING
THE MOST IMPORTANT THING AT THE MOMENT.

>
>> Git is already so much better for the things I do than BK ever was,
>> I'll
>> stick with it.
>
> This is like saying "Windows 3.1 is already so much better for the
> things
> I do than DOS ever was, I'll stick with it."  :-D

Yes, so what's your point?  Mercurial is trying to solve a problem that is
already perfectly well handled for me by Git.   Therefore I have _zero_
motivation to direct my efforts elsewhere.

Cheers,
Sean


