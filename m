Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129190AbRB0UgO>; Tue, 27 Feb 2001 15:36:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129848AbRB0UgE>; Tue, 27 Feb 2001 15:36:04 -0500
Received: from [64.64.109.142] ([64.64.109.142]:25605 "EHLO
	quark.didntduck.org") by vger.kernel.org with ESMTP
	id <S129190AbRB0Ufv>; Tue, 27 Feb 2001 15:35:51 -0500
Message-ID: <3A9C0F86.BA7D5723@didntduck.org>
Date: Tue, 27 Feb 2001 15:35:18 -0500
From: Brian Gerst <bgerst@didntduck.org>
X-Mailer: Mozilla 4.73 [en] (WinNT; U)
X-Accept-Language: en
MIME-Version: 1.0
To: Rob <rob@hereintown.net>
CC: linux-kernel@vger.kernel.org
Subject: Re: Compilation problems
In-Reply-To: <Pine.LNX.4.30.0102271529380.967-100000@robsdigs.hereintown.net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rob wrote:
> 
> gcc --version gives me pgcc-2.91.66
> 
> I have a bootable 2.2.4 kernel I just can no longer recompile it for some
> reason.

IIRC, pgcc is known to be broken.  Use standard gcc 2.91.66 or later.

--

				Brian Gerst
