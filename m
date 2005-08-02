Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261389AbVHBGSG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261389AbVHBGSG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Aug 2005 02:18:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261387AbVHBGSG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Aug 2005 02:18:06 -0400
Received: from outmx013.isp.belgacom.be ([195.238.3.64]:51352 "EHLO
	outmx013.isp.belgacom.be") by vger.kernel.org with ESMTP
	id S261389AbVHBGRp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Aug 2005 02:17:45 -0400
From: Jan De Luyck <lkml@kcore.org>
To: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.6.13-rc5
Date: Tue, 2 Aug 2005 08:17:36 +0200
User-Agent: KMail/1.8.1
References: <Pine.LNX.4.58.0508012201010.3341@g5.osdl.org>
In-Reply-To: <Pine.LNX.4.58.0508012201010.3341@g5.osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200508020817.36565.lkml@kcore.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 02 August 2005 07:07, Linus Torvalds wrote:
> Ok, one more in the series towards final 2.6.13.
>
> This one is small enough that both shortlog and diffstat fit comfortably:
> no big architecture updates or anything like that. Some input, x86-64 and
> ppc updates, and various fairly small fixes in random places.
>
> Some reverts back to 2.6.12 behaviour - you've seen the discussions, and
> I'm sure we'll end up discussing things further for a long while still,
> but the plan is to release 2.6.13 with known behaviour characteristics.

Built & runs fine, built using GCC 4.0.0-2 (Debian Sid) on Pentium M.

Jan

-- 
  I marvel at the strength of human weakness.
