Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265855AbTL3R1Y (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Dec 2003 12:27:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265859AbTL3R1Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Dec 2003 12:27:24 -0500
Received: from mtaw6.prodigy.net ([64.164.98.56]:10908 "EHLO mtaw6.prodigy.net")
	by vger.kernel.org with ESMTP id S265855AbTL3R1X (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Dec 2003 12:27:23 -0500
Date: Tue, 30 Dec 2003 09:27:17 -0800
From: Mike Fedyk <mfedyk@matchmail.com>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [2.4] Is a negative rsect in /proc/partitions normal?
Message-ID: <20031230172717.GT1882@matchmail.com>
Mail-Followup-To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
	linux-kernel@vger.kernel.org
References: <20031230014429.GL1882@matchmail.com> <20031229191106.I6209@schatzie.adilger.int> <20031230024331.GN1882@matchmail.com> <Pine.LNX.4.58L.0312300958050.22101@logos.cnet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58L.0312300958050.22101@logos.cnet>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 30, 2003 at 09:58:19AM -0200, Marcelo Tosatti wrote:
> 
> 
> > struct hd_struct in include/linux/genhd.h:61 has them all unsigned int.
> >
> > How's this patch look against 2.4.23?
> 
> Looks good, applied.
> 

Great, thanks Marcelo!
