Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129689AbRBBS0B>; Fri, 2 Feb 2001 13:26:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129976AbRBBSZu>; Fri, 2 Feb 2001 13:25:50 -0500
Received: from nat-pool.corp.redhat.com ([199.183.24.200]:31562 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S129689AbRBBSZh>; Fri, 2 Feb 2001 13:25:37 -0500
From: Alan Cox <alan@redhat.com>
Message-Id: <200102021825.f12IPCu20705@devserv.devel.redhat.com>
Subject: Re: ReiserFS Oops (2.4.1, deterministic, symlink
To: reiser@namesys.com (Hans Reiser)
Date: Fri, 2 Feb 2001 13:25:12 -0500 (EST)
Cc: mason@suse.com (Chris Mason), alan@redhat.com (Alan Cox),
        kas@informatics.muni.cz (Jan Kasprzak), linux-kernel@vger.kernel.org,
        reiserfs-list@namesys.com
In-Reply-To: <3A7AEFBF.2FBA5822@namesys.com> from "Hans Reiser" at Feb 02, 2001 08:34:55 PM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> So, did Linus say no?  If not, let's ask him with a patch.  Quite simply,
> neither we nor the users should be burdened with this, and the patch removes
> the burden.

Since egcs-1.1.2 and gcc 2.95 miscompile the kernel strstr code dont forget
to stop those being used as well. Oh look you'll need CVS gcc to build the
kernel... ah but wait that misbuilds DAC960.c...

Oh look nothing compiles the kernel.

Congratulations 8)

Alan

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
