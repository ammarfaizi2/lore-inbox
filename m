Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262133AbTCRDbz>; Mon, 17 Mar 2003 22:31:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262141AbTCRDbz>; Mon, 17 Mar 2003 22:31:55 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:8979 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S262133AbTCRDbz>; Mon, 17 Mar 2003 22:31:55 -0500
Message-ID: <3E7695A4.70101@zytor.com>
Date: Mon, 17 Mar 2003 19:42:28 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
Organization: Zytor Communications
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3b) Gecko/20030211
X-Accept-Language: en, sv
MIME-Version: 1.0
To: "H. Peter Anvin" <hpa@zytor.com>
CC: ftpadmin@kernel.org
Subject: Re: kernel.org: Extended downtime announcement
References: <3E763297.7060206@zytor.com>
In-Reply-To: <3E763297.7060206@zytor.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

H. Peter Anvin wrote:
> In order to make the best use of available space, we will unfortunately
> have to reconfigure the RAID arrays on the main kernel.org server.  This
> will result in extended downtime for all kernel.org services, starting
> at 16:00 PST/24:00 UTC this evening, March 17, 2003.  For
> ftp/www/rsync/filehub.kernel.org, this downtime should be in the
> ballpark of 2-3 hours; with luck less; for mirrors.kernel.org, this
> downtime is expected to be 3-4 days.  Services will be phased in as they
> become available, so if you get a "connection refused" from one service
> other services might still be operational.
> 

OK, so I'm an idiot.

The correct downtime estimate is about 6-7 hours.  This is a matter of
simple arithmetric, but somehow I never bothered to actually calculate
it out.

Just to be on the safe side I'm going to estimate kernel.org being back
up around 00:00 PST/08:00 UTC.

Duh.

	-hpa

