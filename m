Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310423AbSCGR2E>; Thu, 7 Mar 2002 12:28:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310421AbSCGR1o>; Thu, 7 Mar 2002 12:27:44 -0500
Received: from adsl-63-194-239-202.dsl.lsan03.pacbell.net ([63.194.239.202]:14841
	"EHLO mmp-linux.matchmail.com") by vger.kernel.org with ESMTP
	id <S310418AbSCGR1f>; Thu, 7 Mar 2002 12:27:35 -0500
Date: Thu, 7 Mar 2002 09:28:06 -0800
From: Mike Fedyk <mfedyk@matchmail.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.19pre2-ac3
Message-ID: <20020307172806.GA28141@matchmail.com>
Mail-Followup-To: Alan Cox <alan@lxorguk.ukuu.org.uk>,
	linux-kernel@vger.kernel.org
In-Reply-To: <E16iyh2-0002OY-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E16iyh2-0002OY-00@the-village.bc.nu>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 07, 2002 at 02:16:27PM +0000, Alan Cox wrote:
> Mostly just merging some of the clearly correct bug fixes and some doc
> fixups this time.  Lots of stuff is still in the queue.
> 
> [+ indicates stuff that went to Marcelo, o stuff that has not,
>  * indicates stuff that is merged in mainstream now, X stuff that proved
>    bad and was dropped out]
> 
> Linux 2.4.19pre2-ac3
> o	Fix quota deadlock and extreme load corruption	(Jan Kara, Chris Mason)

Corruption of what?  Quota meta-data?
