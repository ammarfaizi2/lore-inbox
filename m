Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292328AbSBYWPQ>; Mon, 25 Feb 2002 17:15:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292333AbSBYWPF>; Mon, 25 Feb 2002 17:15:05 -0500
Received: from mx1.afara.com ([63.113.218.20]:9189 "EHLO afara-gw.afara.com")
	by vger.kernel.org with ESMTP id <S292328AbSBYWO7>;
	Mon, 25 Feb 2002 17:14:59 -0500
Subject: Re: Linux 2.4.18
From: Thomas Duffy <Thomas.Duffy.99@alumni.brown.edu>
To: "David S. Miller" <davem@redhat.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20020225.140851.31656207.davem@redhat.com>
In-Reply-To: <20020225200618.0FAE82069E@eos.telenet-ops.be>
	<Pine.LNX.4.21.0202251631170.31542-100000@freak.distro.conectiva> 
	<20020225.140851.31656207.davem@redhat.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0.2.99 Preview Release
Date: 25 Feb 2002 14:14:30 -0800
Message-Id: <1014675271.12310.36.camel@tduffy-lnx.afara.com>
Mime-Version: 1.0
X-OriginalArrivalTime: 25 Feb 2002 22:14:52.0962 (UTC) FILETIME=[D93CE020:01C1BE49]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2002-02-25 at 14:08, David S. Miller wrote:
> 
> We can avoid this kind of mess in the future if the "-rc*" releases
> really are "release candidates" instead of "just another diff".
> Ie. they are done as patches _and_ tarballs, then the final can just
> be done with a "cp" command.

the problem with that is the top level Makefile still needs to be
changed.  the last thing I want is to be running a 2.4.18-rc3 kernel and
have uname tell me it is 2.4.18.

-tduffy

