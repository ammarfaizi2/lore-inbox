Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135861AbREIFlX>; Wed, 9 May 2001 01:41:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135867AbREIFlN>; Wed, 9 May 2001 01:41:13 -0400
Received: from adsl-63-194-239-202.dsl.lsan03.pacbell.net ([63.194.239.202]:37876
	"EHLO mmp-linux.matchmail.com") by vger.kernel.org with ESMTP
	id <S135861AbREIFlD>; Wed, 9 May 2001 01:41:03 -0400
Date: Tue, 8 May 2001 22:41:45 -0700
From: Mike Fedyk <mfedyk@matchmail.com>
To: linux-kernel@vger.kernel.org
Subject: Re: what causes Machine Check exception? revisited (2.2.18)
Message-ID: <20010508224145.A17301@mikef-linux.matchmail.com>
Mail-Followup-To: Mike Fedyk <mfedyk@matchmail.com>,
	linux-kernel@vger.kernel.org
In-Reply-To: <Pine.GSO.4.21.0105071127100.20861-100000@suhkur.cc.ioc.ee> <E14wihd-0003LT-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <E14wihd-0003LT-00@the-village.bc.nu>; from alan@lxorguk.ukuu.org.uk on Mon, May 07, 2001 at 11:57:17AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 07, 2001 at 11:57:17AM +0100, Alan Cox wrote:
> Generally it indicates a CPU problem but I've see it caused by overclocking
> and poorly fitted heatsinks
I've been able to trigger a Machine check error on PPC when trying to boot
directly from OF with a COFF kernel.  The system has worked perfectly with
BootX.

I wonder why this is the first non-x86 report...

Mike
