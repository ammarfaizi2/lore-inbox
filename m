Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261572AbVCIEDU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261572AbVCIEDU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Mar 2005 23:03:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261599AbVCIECp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Mar 2005 23:02:45 -0500
Received: from mail.joq.us ([67.65.12.105]:24457 "EHLO sulphur.joq.us")
	by vger.kernel.org with ESMTP id S261572AbVCIECj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Mar 2005 23:02:39 -0500
To: Matt Mackall <mpm@selenic.com>
Cc: Andrew Morton <akpm@osdl.org>, paul@linuxaudiosystems.com,
       cfriesen@nortelnetworks.com, chrisw@osdl.org, hch@infradead.org,
       rlrevell@joe-job.com, arjanv@redhat.com, mingo@elte.hu,
       alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [request for inclusion] Realtime LSM
References: <20050112185258.GG2940@waste.org>
	<200501122116.j0CLGK3K022477@localhost.localdomain>
	<20050307195020.510a1ceb.akpm@osdl.org>
	<20050308043349.GG3120@waste.org>
	<20050307204044.23e34019.akpm@osdl.org>
	<87acpesnzi.fsf@sulphur.joq.us> <20050308063344.GM3120@waste.org>
	<87zmxd4heb.fsf@sulphur.joq.us> <20050309034442.GU3120@waste.org>
From: "Jack O'Quin" <joq@io.com>
Date: Tue, 08 Mar 2005 22:04:43 -0600
In-Reply-To: <20050309034442.GU3120@waste.org> (Matt Mackall's message of
 "Tue, 8 Mar 2005 19:44:42 -0800")
Message-ID: <87acpd4g84.fsf@sulphur.joq.us>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Corporate Culture,
 linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matt Mackall <mpm@selenic.com> writes:

> On Tue, Mar 08, 2005 at 09:39:24PM -0600, Jack O'Quin wrote:
>> >> 4. is undocumented and has never been tested in any real music studios
>> >
>> > Well you'll have a bit to test it before it goes to Linus.
>> 
>> Only toy tests will be possible without the required userspace tools.
>
> Chris posted the requisite change to pam_limits as well.

Sure.  

You and Chris and I can find a way to test it.  Those are "toy tests".

The RT-LSM has been used for over a year by hundreds (probably
thousands) of musicians in studios making real music.  That's what I
mean by "real music studios".  We won't be able to do that kind of
testing for the rlimits solution until next year.
-- 
  joq
