Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263484AbTJVKU3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Oct 2003 06:20:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263497AbTJVKU3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Oct 2003 06:20:29 -0400
Received: from indigo.cs.bgu.ac.il ([132.72.42.23]:18658 "EHLO
	indigo.cs.bgu.ac.il") by vger.kernel.org with ESMTP id S263482AbTJVKU0
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Oct 2003 06:20:26 -0400
Date: Wed, 22 Oct 2003 12:21:37 +0200 (IST)
From: Nir Tzachar <tzachar@cs.bgu.ac.il>
To: Erik Andersen <andersen@codepoet.org>
cc: linux-fsdevel@vger.kernel.org, <linux-kernel@vger.kernel.org>
Subject: Re: srfs - a new file system.
In-Reply-To: <20031022045708.GA5636@codepoet.org>
Message-ID: <Pine.LNX.4.44_heb2.09.0310221218390.22538-100000@nexus.cs.bgu.ac.il>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Who's work will the caching daemon overwrite?My work, or my
> friends work?

well, in our system, unless u break the symmetry, the daemon will
pick a random file. Since no majority can be found, this is the default.
but, lets say your friend was connected to a third server, and his work
was saved there also. when you'll connect ur laptop, all of ur work will
be lost, and what ull see in only his work ;)


========================================================================
nir.

