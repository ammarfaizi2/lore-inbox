Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275288AbRIZQOS>; Wed, 26 Sep 2001 12:14:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275289AbRIZQOI>; Wed, 26 Sep 2001 12:14:08 -0400
Received: from chunnel.redhat.com ([199.183.24.220]:46070 "EHLO
	sisko.scot.redhat.com") by vger.kernel.org with ESMTP
	id <S275288AbRIZQNt>; Wed, 26 Sep 2001 12:13:49 -0400
Date: Wed, 26 Sep 2001 17:14:12 +0100
From: "Stephen C. Tweedie" <sct@redhat.com>
To: Ryan Mack <rmack@mackman.net>
Cc: linux-kernel@vger.kernel.org, ext2-devel@lists.sourceforge.net
Subject: Re: [BUG?] ext3 0.9.10-2410 - assertion failed
Message-ID: <20010926171412.V3437@redhat.com>
In-Reply-To: <Pine.LNX.4.33.0109241409490.990-100000@mackman.net> <Pine.LNX.4.33.0109241428420.1298-500000@mackman.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.33.0109241428420.1298-500000@mackman.net>; from rmack@mackman.net on Mon, Sep 24, 2001 at 02:40:55PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, Sep 24, 2001 at 02:40:55PM -0700, Ryan Mack wrote:
> At the time, I was running lilo and the system was reconstructing one of
> two RAID-1 mirrors on a pair of SCSI drives connected via a Adaptec
> AHA-2940U2/W controller.  Other than that the system was not under any
> load.

Fixed in CVS.

Cheers,
 Stephen
