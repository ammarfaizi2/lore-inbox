Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268674AbUJTQkB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268674AbUJTQkB (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Oct 2004 12:40:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268609AbUJTQjJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Oct 2004 12:39:09 -0400
Received: from mxfep02.bredband.com ([195.54.107.73]:2272 "EHLO
	mxfep02.bredband.com") by vger.kernel.org with ESMTP
	id S268660AbUJTQh5 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Oct 2004 12:37:57 -0400
To: Pavel Machek <pavel@ucw.cz>
Cc: "Yu, Luming" <luming.yu@intel.com>, linux-kernel@vger.kernel.org
Subject: Re: High pitched noise from laptop: processor.c in linux 2.6
References: <3ACA40606221794F80A5670F0AF15F8405D3BF5B@pdsmsx403>
	<20041018114109.GC4400@openzaurus.ucw.cz>
	<yw1xekjt4fa8.fsf@mru.ath.cx> <20041020154718.GD26439@elf.ucw.cz>
From: =?iso-8859-1?q?M=E5ns_Rullg=E5rd?= <mru@mru.ath.cx>
Date: Wed, 20 Oct 2004 18:37:42 +0200
In-Reply-To: <20041020154718.GD26439@elf.ucw.cz> (Pavel Machek's message of
 "Wed, 20 Oct 2004 17:47:18 +0200")
Message-ID: <yw1x65554a7d.fsf@mru.ath.cx>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Security Through
 Obscurity, linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek <pavel@ucw.cz> writes:

> Hi!
>
>> >> >> ... and lose all the benefits of HZ=1000.  What would happen if one
>> >> >> were to set HZ to a higher value, like 10000?
>> >> 
>> >> There is a similar issue filed on :
>> >> http://bugzilla.kernel.org/show_bug.cgi?id=3406
>> >> 
>> >
>> > He he, someone should write a driver to play music on
>> > those capacitors....
>> 
>> Why not?  They used to have special files that played music on the
>> printer when printed.
>
> Yes, it would be nice... to scare people :-). Also with such piece of
> software it would be rather easy to tell if given mainboard is junk.

I've noticed my laptop makes a slight noise whenever there's heavy
network traffic.  Maybe that could be used to control the pitch even
without a kernel hack.

-- 
Måns Rullgård
mru@mru.ath.cx
