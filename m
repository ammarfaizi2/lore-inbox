Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129165AbRBBNN0>; Fri, 2 Feb 2001 08:13:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129074AbRBBNNQ>; Fri, 2 Feb 2001 08:13:16 -0500
Received: from brutus.conectiva.com.br ([200.250.58.146]:15600 "EHLO
	brutus.conectiva.com.br") by vger.kernel.org with ESMTP
	id <S129165AbRBBNND>; Fri, 2 Feb 2001 08:13:03 -0500
Date: Fri, 2 Feb 2001 11:12:12 -0200 (BRDT)
From: Rik van Riel <riel@conectiva.com.br>
To: Jagan_Pochimireddy@3com.com
cc: Prasanna P Subash <psubash@turbolinux.com>, linux-kernel@vger.kernel.org
Subject: Re: kernel ver 2.4.1 VFS problem
In-Reply-To: <882569E7.0008ABE1.00@hqoutbound.ops.3com.com>
Message-ID: <Pine.LNX.4.21.0102021111300.1321-100000@duckman.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 1 Feb 2001 Jagan_Pochimireddy@3com.com wrote:

> That problem solved by compiling the correct SCSI driver into
> the kernel. Now it is the problem with input console. It says
> Unable to open Input console. This is after mounting VFS.

Same thing ... you haven't compiled in a console driver.

I guess it would be good if you assumed for a while that
all errors you get are forgotten drivers, at least until
you get your system fully booted ;)

Rik
--
Linux MM bugzilla: http://linux-mm.org/bugzilla.shtml

Virtual memory is like a game you can't win;
However, without VM there's truly nothing to lose...

		http://www.surriel.com/
http://www.conectiva.com/	http://distro.conectiva.com/

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
