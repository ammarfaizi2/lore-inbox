Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129826AbRCAT0b>; Thu, 1 Mar 2001 14:26:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129830AbRCAT0W>; Thu, 1 Mar 2001 14:26:22 -0500
Received: from host217-32-133-45.hg.mdip.bt.net ([217.32.133.45]:41989 "EHLO
	penguin.homenet") by vger.kernel.org with ESMTP id <S129826AbRCAT0H>;
	Thu, 1 Mar 2001 14:26:07 -0500
Date: Thu, 1 Mar 2001 19:25:45 +0000 (GMT)
From: Tigran Aivazian <tigran@veritas.com>
To: Hans Reiser <reiser@namesys.com>
cc: James Lewis Nance <jlnance@intrex.net>, linux-kernel@vger.kernel.org,
        brian jenkins <bjenkins@thresholdnetworks.com>,
        dave hecht <dhecht@thresholdnetworks.com>,
        Nikita Danilov <god@namesys.com>
Subject: Re: What is 2.4 Linux networking performance like compared to BSD?
In-Reply-To: <3A9E972D.CEA149B0@namesys.com>
Message-ID: <Pine.LNX.4.21.0103011920470.993-100000@penguin.homenet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 1 Mar 2001, Hans Reiser wrote:
> 
> This is indeed what we should do if we get no answer from the list by someone
> who has already done such work.
> 

Hans,

exactly what you want to measure? I have UP, 2way-SMP and 4way-SMP
machines all of which have at least Linux+FreeBSD installed. All my tests
so far (e.g. comparing NFS servers or filesystems etc) showed Linux (2.4)
to be a lot faster than FreeBSD in all areas. However, to get specific
answers you need to ask specific questions. Ask and you shall receive.

(things like SPEC SFS results I can't tell because it is illegal (without
going through proper steps of publishing them), I shouldn't even be saying
that they show Linux to be much faster :)

Regards,
Tigran



