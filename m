Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292327AbSBYWLp>; Mon, 25 Feb 2002 17:11:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292323AbSBYWLf>; Mon, 25 Feb 2002 17:11:35 -0500
Received: from pizda.ninka.net ([216.101.162.242]:14241 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S292351AbSBYWL0>;
	Mon, 25 Feb 2002 17:11:26 -0500
Date: Mon, 25 Feb 2002 14:08:51 -0800 (PST)
Message-Id: <20020225.140851.31656207.davem@redhat.com>
To: marcelo@conectiva.com.br
Cc: DevilKin-LKML@blindguardian.org, linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.18
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <Pine.LNX.4.21.0202251631170.31542-100000@freak.distro.conectiva>
In-Reply-To: <20020225200618.0FAE82069E@eos.telenet-ops.be>
	<Pine.LNX.4.21.0202251631170.31542-100000@freak.distro.conectiva>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


We can avoid this kind of mess in the future if the "-rc*" releases
really are "release candidates" instead of "just another diff".
Ie. they are done as patches _and_ tarballs, then the final can just
be done with a "cp" command.

That will make errors like this one more likely to be
caught.
