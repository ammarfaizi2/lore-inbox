Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283360AbRLDTsK>; Tue, 4 Dec 2001 14:48:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283218AbRLDTqW>; Tue, 4 Dec 2001 14:46:22 -0500
Received: from eos.telenet-ops.be ([195.130.132.40]:61351 "EHLO
	eos.telenet-ops.be") by vger.kernel.org with ESMTP
	id <S283274AbRLDTpO>; Tue, 4 Dec 2001 14:45:14 -0500
Date: Tue, 4 Dec 2001 20:45:04 +0100
From: Kurt Roeckx <Q@ping.be>
To: Jan Kara <jack@ucw.cz>
Cc: linux-kernel@vger.kernel.org
Subject: Re: OOPS in prune_dcache with 2.4.16 and ext3 corruption
Message-ID: <20011204204504.B4370@ping.be>
In-Reply-To: <20011203154341.A217@ping.be> <20011204183315.B6559@atrey.karlin.mff.cuni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20011204183315.B6559@atrey.karlin.mff.cuni.cz>; from jack@ucw.cz on Tue, Dec 04, 2001 at 06:33:16PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 04, 2001 at 06:33:16PM +0100, Jan Kara wrote:
> 
> > The inodes don't have anything to do with the ISO and were both
> > last written about 12 hours before the crash.
>   Hmm... That is strange... Do you have quota support compiled or not?
> But as I said it has probably no connection to the oops below.

No I don't have quata support.


Kurt

