Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265773AbSKFQHU>; Wed, 6 Nov 2002 11:07:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265777AbSKFQHU>; Wed, 6 Nov 2002 11:07:20 -0500
Received: from pasmtp.tele.dk ([193.162.159.95]:13840 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id <S265773AbSKFQHC>;
	Wed, 6 Nov 2002 11:07:02 -0500
Date: Wed, 6 Nov 2002 17:13:37 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: John Myers <jgmyers@netscape.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.5.46 compilation problem: objcopy: unrecognized option `--rename-section'
Message-ID: <20021106161337.GA1079@mars.ravnborg.org>
Mail-Followup-To: John Myers <jgmyers@netscape.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <3DC84E3C.5020605@netscape.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3DC84E3C.5020605@netscape.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 05, 2002 at 03:03:24PM -0800, John Myers wrote:
> objcopy 2.11.90.0.8 doesn't recognize the --rename-section switch used 
> when building usr/initramfs_data.o.  If this is too old a version, then 
> Documentation/Changes should be updated to list the new minimal requirement.

It is already fixed in Linus's tree. Patch has been posted here as well.

	Sam
