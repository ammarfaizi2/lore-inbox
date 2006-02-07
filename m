Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932475AbWBGRDS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932475AbWBGRDS (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Feb 2006 12:03:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932182AbWBGRDS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Feb 2006 12:03:18 -0500
Received: from percy.comedia.it ([212.97.59.71]:60831 "EHLO percy.comedia.it")
	by vger.kernel.org with ESMTP id S932391AbWBGRDQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Feb 2006 12:03:16 -0500
Date: Tue, 7 Feb 2006 18:03:15 +0100
From: Luca Berra <bluca@comedia.it>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: Neil Brown <neilb@suse.de>, linux-raid@vger.kernel.org,
       klibc list <klibc@zytor.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [klibc] Re: Exporting which partitions to md-configure
Message-ID: <20060207170315.GC12480@percy.comedia.it>
Mail-Followup-To: "H. Peter Anvin" <hpa@zytor.com>,
	Neil Brown <neilb@suse.de>, linux-raid@vger.kernel.org,
	klibc list <klibc@zytor.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <17374.47368.715991.422607@cse.unsw.edu.au> <43DEC095.2090507@zytor.com> <17374.50399.1898.458649@cse.unsw.edu.au> <43DEC5DC.1030709@zytor.com> <17382.43646.567406.987585@cse.unsw.edu.au> <43E80A5A.5040002@zytor.com> <20060207104311.GD22221@percy.comedia.it> <43E8C0F3.5080205@zytor.com> <20060207164730.GA12480@percy.comedia.it> <43E8D0F9.50205@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <43E8D0F9.50205@zytor.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 07, 2006 at 08:55:21AM -0800, H. Peter Anvin wrote:
>Luca Berra wrote:
>>
>>making it harder for the user is a good thing, but please not at the
>>expense of usability
>>
>
>What's the usability problem?
>
if we fail to support all partitioning schemes and we do not support
non partitioned devices.

if we manage to support all this without too much code bloat i'll shut
up.

L.

-- 
Luca Berra -- bluca@comedia.it
        Communication Media & Services S.r.l.
 /"\
 \ /     ASCII RIBBON CAMPAIGN
  X        AGAINST HTML MAIL
 / \
