Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S274903AbTHLADH (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Aug 2003 20:03:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S274907AbTHLADG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Aug 2003 20:03:06 -0400
Received: from adsl-63-194-239-202.dsl.lsan03.pacbell.net ([63.194.239.202]:32785
	"EHLO mmp-linux.matchmail.com") by vger.kernel.org with ESMTP
	id S274903AbTHLADF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Aug 2003 20:03:05 -0400
Date: Mon, 11 Aug 2003 17:03:03 -0700
From: Mike Fedyk <mfedyk@matchmail.com>
To: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.6.0-test3 (compile statistics)
Message-ID: <20030812000303.GF1027@matchmail.com>
Mail-Followup-To: Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.44.0308082228470.1852-100000@home.osdl.org> <1060643227.30492.13.camel@cherrypit.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1060643227.30492.13.camel@cherrypit.pdx.osdl.net>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 11, 2003 at 04:07:08PM -0700, John Cherry wrote:
> Compile statistics: 2.6.0-test3
> Compiler: gcc 3.2.2
> Script: http://developer.osdl.org/~cherry/compile/compregress.sh
> 
>                bzImage       bzImage        modules
>              (defconfig)  (allmodconfig) (allmodconfig)
> 
> 2.6.0-test3  0 warnings     7 warnings    984 warnings
> 2.6.0-test2  0 warnings     7 warnings   1201 warnings
                                           ^^^^
					   
Over 200 warnings removed.  Nice.					   
