Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286825AbSCRQVR>; Mon, 18 Mar 2002 11:21:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288019AbSCRQVH>; Mon, 18 Mar 2002 11:21:07 -0500
Received: from adsl-63-194-239-202.dsl.lsan03.pacbell.net ([63.194.239.202]:23278
	"EHLO mmp-linux.matchmail.com") by vger.kernel.org with ESMTP
	id <S286825AbSCRQVA>; Mon, 18 Mar 2002 11:21:00 -0500
Date: Mon, 18 Mar 2002 08:22:09 -0800
From: Mike Fedyk <mfedyk@matchmail.com>
To: Adam Johansson <macadam@madsci.se>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Suspicious about 2.4.18
Message-ID: <20020318162209.GG2254@matchmail.com>
Mail-Followup-To: Adam Johansson <macadam@madsci.se>,
	linux-kernel@vger.kernel.org
In-Reply-To: <200203180743.g2I7hfmj007702@bert.webservepro.com> <Pine.LNX.4.33.0203181010520.7930-100000@macadam.madscilab.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 18, 2002 at 10:20:50AM +0100, Adam Johansson wrote:
> // --- start ---
> #!/bin/tcsh
> while (1)
>   date
> end
> // --- end ---
> 
> ./timescript > output
> 
> output gives me this;
> Fri Mar 15 10:17:12 CET 2002
> Fri Mar 15 10:17:12 CET 2002
> Fri Mar 15 10:17:12 CET 2002
> Fri Mar 15 10:17:12 CET 2002
> Fri Mar 15 10:17:12 CET 2002
> Fri Mar 15 10:17:12 CET 2002
> Fri Mar 15 11:29:43 CET 2002
> Fri Mar 15 11:29:43 CET 2002
> Fri Mar 15 11:29:43 CET 2002
> Fri Mar 15 10:17:13 CET 2002
> Fri Mar 15 10:17:13 CET 2002
> Fri Mar 15 10:17:13 CET 2002
> Fri Mar 15 10:17:13 CET 2002
> Fri Mar 15 10:17:13 CET 2002
> Fri Mar 15 10:17:13 CET 2002
> 
> 
> Which clearly shows that something is very very strange.
> I've no idea where or why this happens but since upgrading to 2.4.19pre3
> helped I assume that there is something in the kernel that is wrong.
> I run SuSE7.2 with a vanilla 2.4.18 (now 2.4.19pre3).
> 

Can you try to reproduce with pre1 and pre2?
