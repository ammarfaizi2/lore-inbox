Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132879AbRDUUXf>; Sat, 21 Apr 2001 16:23:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132883AbRDUUXZ>; Sat, 21 Apr 2001 16:23:25 -0400
Received: from saturn.cs.uml.edu ([129.63.8.2]:41999 "EHLO saturn.cs.uml.edu")
	by vger.kernel.org with ESMTP id <S132879AbRDUUXM>;
	Sat, 21 Apr 2001 16:23:12 -0400
From: "Albert D. Cahalan" <acahalan@cs.uml.edu>
Message-Id: <200104212023.f3LKN7P188973@saturn.cs.uml.edu>
Subject: Re: Request for comment -- a better attribution system
To: esr@thyrsus.com
Date: Sat, 21 Apr 2001 16:23:06 -0400 (EDT)
Cc: linux-kernel@vger.kernel.org (CML2), kbuild-devel@lists.sourceforge.net
In-Reply-To: <20010421114942.A26415@thyrsus.com> from "Eric S. Raymond" at Apr 21, 2001 11:49:42 AM
X-Mailer: ELM [version 2.5 PL2]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Eric S. Raymond writes:

> This is a proposal for an attribution metadata system in the Linux
> kernel sources.  The goal of the system is to make it easy for
> people reading any given piece of code to identify the responsible
> maintainer.  The motivation for this proposal is that the present
> system, a single top-level MAINTAINERS file, doesn't seem to be
> scaling well.

It is nice to have a single file for grep. With the proposed
changes one would sometimes need to grep every file.

