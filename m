Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314672AbSDTSDR>; Sat, 20 Apr 2002 14:03:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314677AbSDTSCZ>; Sat, 20 Apr 2002 14:02:25 -0400
Received: from adsl-63-194-239-202.dsl.lsan03.pacbell.net ([63.194.239.202]:17402
	"EHLO mmp-linux.matchmail.com") by vger.kernel.org with ESMTP
	id <S314701AbSDTSBH>; Sat, 20 Apr 2002 14:01:07 -0400
Date: Sat, 20 Apr 2002 11:03:30 -0700
From: Mike Fedyk <mfedyk@matchmail.com>
To: Alan Cox <alan@redhat.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.19pre7-ac2
Message-ID: <20020420180330.GK574@matchmail.com>
Mail-Followup-To: Alan Cox <alan@redhat.com>, linux-kernel@vger.kernel.org
In-Reply-To: <200204200038.g3K0c5110782@devserv.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 19, 2002 at 08:38:05PM -0400, Alan Cox wrote:
> o	Back out problem bridge update			(Mike Fedyk)

Thanks, but it was only a patch -NRsp1 of Lennert Buytenhek's patch.  Also,
Lennert has sent me a patch that should fix it without backing this out,
though I have yet to test it.  I'll do that on monday or tuesday.

After that I'll send you a patch with the update.

Mike
