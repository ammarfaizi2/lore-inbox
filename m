Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136055AbRAWDbQ>; Mon, 22 Jan 2001 22:31:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136056AbRAWDa4>; Mon, 22 Jan 2001 22:30:56 -0500
Received: from sgigate.SGI.COM ([204.94.209.1]:25335 "EHLO
	gate-sgigate.sgi.com") by vger.kernel.org with ESMTP
	id <S136055AbRAWDaw>; Mon, 22 Jan 2001 22:30:52 -0500
Date: Mon, 22 Jan 2001 06:31:10 -0200
From: Ralf Baechle <ralf@uni-koblenz.de>
To: mkloppstech@freenet.de
Cc: linux-kernel@vger.kernel.org
Subject: Re: oops,  signal 11
Message-ID: <20010122063110.C1052@bacchus.dhis.org>
In-Reply-To: <200101201246.NAA15788@john.epistle>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <200101201246.NAA15788@john.epistle>; from mkloppstech@freenet.de on Sat, Jan 20, 2001 at 01:46:50PM +0100
X-Accept-Language: de,en,fr
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 20, 2001 at 01:46:50PM +0100, mkloppstech@freenet.de wrote:

> I know that signal 11 with gcc is a sign of bad hardware; however  it
> strikes me that I don't get random oopses - a whole bunch of them is appended.

The compiler tends to hammer harder on the memory than the kernel; this
is a sign of the great effort which was taken to optimize the kernel's
cache usage.

  Ralf
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
