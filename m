Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264745AbSLPPDi>; Mon, 16 Dec 2002 10:03:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265777AbSLPPDi>; Mon, 16 Dec 2002 10:03:38 -0500
Received: from elixir.e.kth.se ([130.237.48.5]:35337 "EHLO elixir.e.kth.se")
	by vger.kernel.org with ESMTP id <S264745AbSLPPDi>;
	Mon, 16 Dec 2002 10:03:38 -0500
To: "Scott Robert Ladd" <scott@coyotegulch.com>
Cc: <root@chaos.analogic.com>, "Brian Jackson" <brian-kernel-list@mdrx.com>,
       "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
Subject: Re: /proc/cpuinfo and hyperthreading
References: <FKEAJLBKJCGBDJJIPJLJIELIDLAA.scott@coyotegulch.com>
From: mru@users.sourceforge.net (=?iso-8859-1?q?M=E5ns_Rullg=E5rd?=)
Date: 16 Dec 2002 16:11:23 +0100
In-Reply-To: "Scott Robert Ladd"'s message of "Mon, 16 Dec 2002 09:56:27 -0500"
Message-ID: <yw1xr8cigfs4.fsf@lakritspipa.e.kth.se>
User-Agent: Gnus/5.0807 (Gnus v5.8.7) XEmacs/21.1 (Channel Islands)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Scott Robert Ladd" <scott@coyotegulch.com> writes:

> > How do you know this? How can I learn what Windows does with
> > Win/2000/professional?
> 
> Run the Windows Task Manager and selected the Performance tab; on my system,
> it shows two separate graphs, one for each logical CPU.

It's easy to write a program that displays any number of graphs
vaguely related to the system load.  How do we know that the
performance meter isn't lying?

-- 
Måns Rullgård
mru@users.sf.net
