Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261509AbRE0KlP>; Sun, 27 May 2001 06:41:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261547AbRE0KlF>; Sun, 27 May 2001 06:41:05 -0400
Received: from f00f.stub.clear.net.nz ([203.167.224.51]:38660 "HELO
	metastasis.f00f.org") by vger.kernel.org with SMTP
	id <S261509AbRE0Kks>; Sun, 27 May 2001 06:40:48 -0400
Date: Sun, 27 May 2001 22:40:45 +1200
From: Chris Wedgwood <cw@f00f.org>
To: Jaswinder Singh <jaswinder.singh@3disystems.com>
Cc: stepken@little-idiot.de, linux-kernel@vger.kernel.org
Subject: Re: IDE Performance lack !
Message-ID: <20010527224045.B3556@metastasis.f00f.org>
In-Reply-To: <01052622193100.01317@linux.zuhause.de> <00a101c0e642$4f0791a0$52a6b3d0@Toshiba>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <00a101c0e642$4f0791a0$52a6b3d0@Toshiba>; from jaswinder.singh@3disystems.com on Sat, May 26, 2001 at 05:16:42PM -0700
X-No-Archive: Yes
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 26, 2001 at 05:16:42PM -0700, Jaswinder Singh wrote:

    When ever i copy big data (around 400 to 700 MB ) from one
    partion to another my machine do not response at all (i can not
    work on another shell) during data transfer.

Both paritions on the same spindle? That's going to suck no matter
what you do... but it shouldn't be as bad as you describe. Have you
tried 2.2.x ?



  --cw
