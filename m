Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S274983AbTHQAJi (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 16 Aug 2003 20:09:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S274985AbTHQAJi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Aug 2003 20:09:38 -0400
Received: from adsl-63-194-239-202.dsl.lsan03.pacbell.net ([63.194.239.202]:46353
	"EHLO mmp-linux.matchmail.com") by vger.kernel.org with ESMTP
	id S274983AbTHQAJh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Aug 2003 20:09:37 -0400
Date: Sat, 16 Aug 2003 17:09:36 -0700
From: Mike Fedyk <mfedyk@matchmail.com>
To: maney@pobox.com
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.22-rc2 ext2 filesystem corruption
Message-ID: <20030817000936.GV1027@matchmail.com>
Mail-Followup-To: maney@pobox.com,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20030812213645.GA1079@furrr.two14.net> <Pine.LNX.4.44.0308131155090.4279-100000@localhost.localdomain> <20030813181330.GA1122@furrr.two14.net> <1060803612.9130.37.camel@dhcp23.swansea.linux.org.uk> <20030816063512.GA1075@furrr.two14.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030816063512.GA1075@furrr.two14.net>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 16, 2003 at 01:35:12AM -0500, Martin Maney wrote:
> So what I'm seeing is a failure at 100MHz operation.  Is there any way
> to put the Promise into 66MHz mode (other than using a drive that runs
> no faster)?  Because at this point I don't have any practical way to
> rule out the possibility that the cable/drive are what's marginal at
> 100MHz; aside from the Promise, I don't have anything faster than a
> UDMA66 card (which works fine with them).

Just so you know.  The ide cards are not rated in MHz, but MB/s.  That's
MegaBytes per second.
