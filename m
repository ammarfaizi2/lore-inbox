Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135179AbRAZR4N>; Fri, 26 Jan 2001 12:56:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136066AbRAZR4D>; Fri, 26 Jan 2001 12:56:03 -0500
Received: from oxmail2.ox.ac.uk ([163.1.2.1]:48091 "EHLO oxmail.ox.ac.uk")
	by vger.kernel.org with ESMTP id <S135179AbRAZRzn>;
	Fri, 26 Jan 2001 12:55:43 -0500
Date: Fri, 26 Jan 2001 17:54:33 +0000
From: David Welch <david.welch@st-edmund-hall.oxford.ac.uk>
To: linux-kernel@vger.kernel.org
Subject: Re: Linux Post codes during runtime, possibly OT
Message-ID: <20010126175433.A2268@whitehall1-5.seh.ox.ac.uk>
In-Reply-To: <Pine.LNX.3.95.1010126085110.265A-100000@chaos.analogic.com> <3A71A3AE.DE587EEE@transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3A71A3AE.DE587EEE@transmeta.com>; from hpa@transmeta.com on Fri, Jan 26, 2001 at 08:19:58AM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 26, 2001 at 08:19:58AM -0800, H. Peter Anvin wrote:
> 
> A better idea might be to find out what port, if any, Windows uses.  If
> Windows does it, it is usually safe.
> 
Windows NT 4 Service Pack 6 doesn't use any delay however 
READ/WRITE_PORT_* are implemented as indirect function calls so they may
be slowed down enough.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
