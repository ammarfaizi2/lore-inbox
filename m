Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288703AbSADRyz>; Fri, 4 Jan 2002 12:54:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281450AbSADRyp>; Fri, 4 Jan 2002 12:54:45 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:39433 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S280984AbSADRyb>; Fri, 4 Jan 2002 12:54:31 -0500
Date: Fri, 4 Jan 2002 09:53:28 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Jeff Garzik <jgarzik@mandrakesoft.com>
cc: Nikita Danilov <Nikita@Namesys.COM>,
        Alessandro Suardi <alessandro.suardi@oracle.com>,
        <linux-kernel@vger.kernel.org>, <andries.brouwer@cwi.nl>,
        <viro@math.psu.edu>
Subject: Re: 2.5.2-pre7 still missing bits of kdev_t
In-Reply-To: <3C35EB95.FAE9E4BE@mandrakesoft.com>
Message-ID: <Pine.LNX.4.33.0201040953040.5360-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 4 Jan 2002, Jeff Garzik wrote:
>
> As mentioned to viro on IRC, I think init_special_inode should take
> major and minor arguments, to nudge the filesystem implementors into
> thinking that major and minor should be treated separately, and be given
> additional thought as to how they are encoded on-disk.

Yes. If somebody sends me a patch, I'll apply it in a jiffy.

		Linus

