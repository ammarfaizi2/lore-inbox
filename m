Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261461AbVCIDqE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261461AbVCIDqE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Mar 2005 22:46:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261572AbVCIDqC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Mar 2005 22:46:02 -0500
Received: from waste.org ([216.27.176.166]:47269 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S261461AbVCIDph (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Mar 2005 22:45:37 -0500
Date: Tue, 8 Mar 2005 19:44:42 -0800
From: Matt Mackall <mpm@selenic.com>
To: "Jack O'Quin" <joq@io.com>
Cc: Andrew Morton <akpm@osdl.org>, paul@linuxaudiosystems.com,
       cfriesen@nortelnetworks.com, chrisw@osdl.org, hch@infradead.org,
       rlrevell@joe-job.com, arjanv@redhat.com, mingo@elte.hu,
       alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [request for inclusion] Realtime LSM
Message-ID: <20050309034442.GU3120@waste.org>
References: <20050112185258.GG2940@waste.org> <200501122116.j0CLGK3K022477@localhost.localdomain> <20050307195020.510a1ceb.akpm@osdl.org> <20050308043349.GG3120@waste.org> <20050307204044.23e34019.akpm@osdl.org> <87acpesnzi.fsf@sulphur.joq.us> <20050308063344.GM3120@waste.org> <87zmxd4heb.fsf@sulphur.joq.us>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87zmxd4heb.fsf@sulphur.joq.us>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 08, 2005 at 09:39:24PM -0600, Jack O'Quin wrote:
> >> 4. is undocumented and has never been tested in any real music studios
> >
> > Well you'll have a bit to test it before it goes to Linus.
> 
> Only toy tests will be possible without the required userspace tools.

Chris posted the requisite change to pam_limits as well.

-- 
Mathematics is the supreme nostalgia of our time.
