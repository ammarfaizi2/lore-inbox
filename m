Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312150AbSCRFxA>; Mon, 18 Mar 2002 00:53:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312202AbSCRFwu>; Mon, 18 Mar 2002 00:52:50 -0500
Received: from adsl-63-194-239-202.dsl.lsan03.pacbell.net ([63.194.239.202]:3567
	"EHLO mmp-linux.matchmail.com") by vger.kernel.org with ESMTP
	id <S312150AbSCRFwf>; Mon, 18 Mar 2002 00:52:35 -0500
Date: Sun, 17 Mar 2002 21:53:47 -0800
From: Mike Fedyk <mfedyk@matchmail.com>
To: Richard Gooch <rgooch@ras.ucalgary.ca>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Another entry for the MCE-hang list
Message-ID: <20020318055347.GF2254@matchmail.com>
Mail-Followup-To: Richard Gooch <rgooch@ras.ucalgary.ca>,
	linux-kernel@vger.kernel.org
In-Reply-To: <200203180546.g2I5kP412586@vindaloo.ras.ucalgary.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 17, 2002 at 10:46:25PM -0700, Richard Gooch wrote:
>   Hi, all. I just booted 2.4.19-pre3, and it hung right after the MCE
> message. This is an Asus P2B-D with two Intel 450 MHz PIII's. Output
> of /proc/cpuinfo appended.
> 

Won't that change hang on *all* pii/piii systems? (I've only tested it on
one pii box)
