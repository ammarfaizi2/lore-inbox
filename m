Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293658AbSB1Sgi>; Thu, 28 Feb 2002 13:36:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293663AbSB1Sfl>; Thu, 28 Feb 2002 13:35:41 -0500
Received: from [209.195.52.114] ([209.195.52.114]:44804 "HELO [209.195.52.30]")
	by vger.kernel.org with SMTP id <S293624AbSB1Sdp>;
	Thu, 28 Feb 2002 13:33:45 -0500
From: David Lang <david.lang@digitalinsight.com>
To: "Mark H. Wood" <mwood@IUPUI.Edu>
Cc: linux-kernel@vger.kernel.org
Date: Thu, 28 Feb 2002 10:31:21 -0800 (PST)
Subject: Re: Kernel module ethics.
In-Reply-To: <Pine.LNX.4.33.0202281054570.4589-100000@mhw.ULib.IUPUI.Edu>
Message-ID: <Pine.LNX.4.44.0202281028450.15808-100000@dlang.diginsite.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

just to note that if your hardware put the firmware in flash instead of
ram so that it only needed to be loaded if it changes you would avoid the
griping about the firmware not being available.

David Lang


 On Thu, 28 Feb 2002, Mark H. Wood wrote:

> Date: Thu, 28 Feb 2002 11:04:39 -0500 (EST)
> From: Mark H. Wood <mwood@IUPUI.Edu>
> To: unlisted-recipients:  ;
> Cc: linux-kernel@vger.kernel.org
> Subject: Re: Kernel module ethics.
>
> On Thu, 28 Feb 2002, Helge Hafting wrote:
> [much snipped]
> > Generally, the more open the better.  Keep in mind that buying
> > hw that needs a closed-source driver is something we do _only_ when
> > no competing product with a GPL driver exist.  Your competitors
> > might go the GPL way even if you don't.  Many users of closed drivers
> > do so because they converted a machine from windows to linux.
> > If they buy specifically for linux, they buy something well-supported.
> > And the ideal then is a driver in the official tree.  The second
> > best is a open source driver that might get into the tree - it just
> > hasn't happened yet.  A closed driver at least initiates a web search
> > for other harware...
>
> I want to underscore this.  I don't buy hardware until I know that it's
> possible to *keep* it running with Linux.  If the driver is closed-source,
> I'll buy something else or do without.  Secret magic firmware would be
> grudgingly accepted, but only if there isn't a comparable product with no
> secrets.
>
> --
> Mark H. Wood, Lead System Programmer   mwood@IUPUI.Edu
> Our lives are forever changed.  But *that* is exactly as it always was.
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>
