Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311025AbSGFUxO>; Sat, 6 Jul 2002 16:53:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311749AbSGFUxN>; Sat, 6 Jul 2002 16:53:13 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:54773 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S311025AbSGFUxM>;
	Sat, 6 Jul 2002 16:53:12 -0400
Date: Sat, 6 Jul 2002 16:55:44 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: "Albert D. Cahalan" <acahalan@cs.uml.edu>
cc: "J.A. Magallon" <jamagallon@able.es>,
       Lista Linux-BProc <bproc-users@lists.sourceforge.net>,
       Lista Linux-Cluster <linux-cluster@nl.linux.org>,
       Lista Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Is 'transname' still alive ?
In-Reply-To: <200207062036.g66KaMx160715@saturn.cs.uml.edu>
Message-ID: <Pine.GSO.4.21.0207061654160.20648-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 6 Jul 2002, Albert D. Cahalan wrote:

> It made the 2.1.44 kernel horribly bad. It used to provide
> the POSIX-prohibited ability to do rmdir(".") safely.

"Safely" is not the word I'd use for something that allowed to
subvert sticky bit on directories, to start with...

