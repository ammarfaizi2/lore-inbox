Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287134AbSBZNhT>; Tue, 26 Feb 2002 08:37:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287408AbSBZNhJ>; Tue, 26 Feb 2002 08:37:09 -0500
Received: from office.mandrakesoft.com ([195.68.114.34]:60413 "EHLO
	office.mandrakesoft.com") by vger.kernel.org with ESMTP
	id <S287134AbSBZNhC>; Tue, 26 Feb 2002 08:37:02 -0500
To: "David S. Miller" <davem@redhat.com>
Cc: marcelo@conectiva.com.br, DevilKin-LKML@blindguardian.org,
        linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.18
In-Reply-To: <20020225200618.0FAE82069E@eos.telenet-ops.be>
	<Pine.LNX.4.21.0202251631170.31542-100000@freak.distro.conectiva>
	<20020225.140851.31656207.davem@redhat.com>
X-Url: http://www.lfcia.org/~quintela
From: Juan Quintela <quintela@mandrakesoft.com>
In-Reply-To: <20020225.140851.31656207.davem@redhat.com>
Date: 26 Feb 2002 14:25:00 +0100
Message-ID: <m2bsecjryr.fsf@localhost.mandrakesoft.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "david" == David S Miller <davem@redhat.com> writes:

Hi


david> We can avoid this kind of mess in the future if the "-rc*" releases
david> really are "release candidates" instead of "just another diff".
david> Ie. they are done as patches _and_ tarballs, then the final can just
david> be done with a "cp" command.

No, think of EXTRAVERSION.

Later, Juan.

-- 
In theory, practice and theory are the same, but in practice they 
are different -- Larry McVoy
