Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261375AbUJUOLS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261375AbUJUOLS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Oct 2004 10:11:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268733AbUJUOIF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Oct 2004 10:08:05 -0400
Received: from mxfep01.bredband.com ([195.54.107.70]:15057 "EHLO
	mxfep01.bredband.com") by vger.kernel.org with ESMTP
	id S261375AbUJTOsU convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Oct 2004 10:48:20 -0400
To: Pavel Machek <pavel@ucw.cz>
Cc: "Yu, Luming" <luming.yu@intel.com>, linux-kernel@vger.kernel.org
Subject: Re: High pitched noise from laptop: processor.c in linux 2.6
References: <3ACA40606221794F80A5670F0AF15F8405D3BF5B@pdsmsx403>
	<20041018114109.GC4400@openzaurus.ucw.cz>
From: =?iso-8859-1?q?M=E5ns_Rullg=E5rd?= <mru@mru.ath.cx>
Date: Wed, 20 Oct 2004 16:47:59 +0200
In-Reply-To: <20041018114109.GC4400@openzaurus.ucw.cz> (Pavel Machek's
 message of "Mon, 18 Oct 2004 13:41:09 +0200")
Message-ID: <yw1xekjt4fa8.fsf@mru.ath.cx>
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
>> >> ... and lose all the benefits of HZ=1000.  What would happen if one
>> >> were to set HZ to a higher value, like 10000?
>> 
>> There is a similar issue filed on :
>> http://bugzilla.kernel.org/show_bug.cgi?id=3406
>> 
>
> He he, someone should write a driver to play music on
> those capacitors....

Why not?  They used to have special files that played music on the
printer when printed.

-- 
Måns Rullgård
mru@mru.ath.cx
