Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280524AbRLDCiq>; Mon, 3 Dec 2001 21:38:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282379AbRLCXvB>; Mon, 3 Dec 2001 18:51:01 -0500
Received: from adsl-63-194-239-202.dsl.lsan03.pacbell.net ([63.194.239.202]:12789
	"EHLO mmp-linux.matchmail.com") by vger.kernel.org with ESMTP
	id <S285122AbRLCUjx>; Mon, 3 Dec 2001 15:39:53 -0500
Date: Mon, 3 Dec 2001 12:39:46 -0800
From: Mike Fedyk <mfedyk@matchmail.com>
To: Anton Altaparmakov <aia21@cam.ac.uk>
Cc: "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
Subject: Re: Incremental prepatches
Message-ID: <20011203123946.H489@mikef-linux.matchmail.com>
Mail-Followup-To: Anton Altaparmakov <aia21@cam.ac.uk>,
	"H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
In-Reply-To: <3C089BDB.4020801@zytor.com> <5.1.0.14.2.20011201181316.00b0a400@pop.cus.cam.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5.1.0.14.2.20011201181316.00b0a400@pop.cus.cam.ac.uk>
User-Agent: Mutt/1.3.23i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 01, 2001 at 06:14:16PM +0000, Anton Altaparmakov wrote:
> At 08:59 01/12/01, H. Peter Anvin wrote:
> >I have created a robot on kernel.org which makes incremental prepatches 
> >available.
> 
> Fantastic! Thanks! Finally I can stop doing the diffs myself. (-:
> 

interdiff is great for that.  Just take two patches against the same base,
and you get incremental patches. :)

mf
