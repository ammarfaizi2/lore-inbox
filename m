Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267062AbRGNOtR>; Sat, 14 Jul 2001 10:49:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267647AbRGNOtH>; Sat, 14 Jul 2001 10:49:07 -0400
Received: from weta.f00f.org ([203.167.249.89]:20867 "HELO weta.f00f.org")
	by vger.kernel.org with SMTP id <S267062AbRGNOs5>;
	Sat, 14 Jul 2001 10:48:57 -0400
Date: Sun, 15 Jul 2001 02:48:59 +1200
From: Chris Wedgwood <cw@f00f.org>
To: Paul Jakma <paulj@alphyra.ie>
Cc: Andreas Dilger <adilger@turbolinux.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 64 bit scsi read/write
Message-ID: <20010715024859.A6722@weta.f00f.org>
In-Reply-To: <Pine.LNX.4.33.0107141325460.1063-100000@rossi.itg.ie>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.33.0107141325460.1063-100000@rossi.itg.ie>
User-Agent: Mutt/1.3.18i
X-No-Archive: Yes
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 14, 2001 at 01:27:37PM +0100, Paul Jakma wrote:

    so ext3 supports having the journal somewhere else then. question: can
    the journal be on tmpfs?

*why* would you want to to do this?


  --cw
