Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292085AbSBTR3e>; Wed, 20 Feb 2002 12:29:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292087AbSBTR3Z>; Wed, 20 Feb 2002 12:29:25 -0500
Received: from adsl-63-194-239-202.dsl.lsan03.pacbell.net ([63.194.239.202]:57591
	"EHLO mmp-linux.matchmail.com") by vger.kernel.org with ESMTP
	id <S292083AbSBTR3J>; Wed, 20 Feb 2002 12:29:09 -0500
Date: Wed, 20 Feb 2002 09:29:28 -0800
From: Mike Fedyk <mfedyk@matchmail.com>
To: Riot777 <riot777@skrzynka.pl>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Please help me with newer 2.4.xx
Message-ID: <20020220172928.GB15228@matchmail.com>
Mail-Followup-To: Riot777 <riot777@skrzynka.pl>,
	linux-kernel@vger.kernel.org
In-Reply-To: <000401c1ba31$082104b0$d8644cd5@krios>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <000401c1ba31$082104b0$d8644cd5@krios>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 20, 2002 at 06:04:51PM +0100, Riot777 wrote:
>   Dear Linux Kernel community pleez help me I have some serious problem with
> 2.4xx newer kernels and my softmodem Motorola sm56 driver compabilyty.
> The problem is in the kernells from 2.4.8 to 2.4.14/16/17 becouse I've been

Ok, if you see problems starting with 2.4.8, can you narrow it down to which
2.4.8pre kernel starts the problem also?

> Driver is a closed source drv in program which is making a module cold
> sm56.o

The community isn't too keen on giving free support for non-free (ie, closed
source) drivers.  Maybe after you have found the exact pre kernel that
starts exhibiting the problems, there might be someone willing to help.

Compile some -pre kernels, and let us know which one starts causing this
problem.

Mike
