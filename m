Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289017AbSAFTh7>; Sun, 6 Jan 2002 14:37:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289018AbSAFTht>; Sun, 6 Jan 2002 14:37:49 -0500
Received: from lacrosse.corp.redhat.com ([12.107.208.154]:2678 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id <S289017AbSAFThc>; Sun, 6 Jan 2002 14:37:32 -0500
To: jtv <jtv@xs4all.nl>
Cc: dewar@gnat.com, jbuck@synopsys.COM, gcc@gcc.gnu.org,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.linuxppc.org,
        paulus@samba.org, trini@kernel.crashing.org, velco@fadata.bg
Subject: Re: [PATCH] C undefined behavior fix
In-Reply-To: <20020103001241.E37DFF2EC6@nile.gnat.com>
	<20020103013240.F19933@xs4all.nl>
From: Alexandre Oliva <aoliva@redhat.com>
Organization: GCC Team, Red Hat
Date: 06 Jan 2002 17:37:07 -0200
In-Reply-To: jtv's message of "Thu, 3 Jan 2002 01:32:40 +0100"
Message-ID: <oradvrgtjw.fsf@free.redhat.lsd.ic.unicamp.br>
User-Agent: Gnus/5.0805 (Gnus v5.8.5) Emacs/20.7
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Jan  2, 2002, jtv <jtv@xs4all.nl> wrote:

> (Yes, I'm a pedant.  I'm pining for the day when gcc will support the
> options "-ffascist -Wanal")

How about introducing the options `-flame -War' :-)

-- 
Alexandre Oliva   Enjoy Guarana', see http://www.ic.unicamp.br/~oliva/
Red Hat GCC Developer                  aoliva@{cygnus.com, redhat.com}
CS PhD student at IC-Unicamp        oliva@{lsd.ic.unicamp.br, gnu.org}
Free Software Evangelist    *Please* write to mailing lists, not to me
