Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267043AbTCEPzd>; Wed, 5 Mar 2003 10:55:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267244AbTCEPzc>; Wed, 5 Mar 2003 10:55:32 -0500
Received: from meryl.it.uu.se ([130.238.12.42]:57731 "EHLO meryl.it.uu.se")
	by vger.kernel.org with ESMTP id <S267043AbTCEPzb>;
	Wed, 5 Mar 2003 10:55:31 -0500
From: Mikael Pettersson <mikpe@user.it.uu.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15974.8294.722607.822634@gargle.gargle.HOWL>
Date: Wed, 5 Mar 2003 17:05:58 +0100
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Unable to boot a raw kernel image :??
In-Reply-To: <3E661F8F.50100@zytor.com>
References: <20021129132126.GA102@DervishD>
	<3DF08DD0.BA70DA62@gmx.de>
	<b453er$qo7$1@cesium.transmeta.com>
	<15974.6329.574794.597753@gargle.gargle.HOWL>
	<3E661C1D.904@zytor.com>
	<15974.7817.474141.453202@gargle.gargle.HOWL>
	<3E661F8F.50100@zytor.com>
X-Mailer: VM 6.90 under Emacs 20.7.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

H. Peter Anvin writes:
 > Mikael Pettersson wrote:
 > >  > 
 > >  > This is the patch I'm trying to get Linus to accept.
 > > 
 > > That's similar to what you posted to LKML a while ago, and
 > > it has the limitations of requiring mountable /dev/fd0, which
 > > needs a magic entry in /etc/fstab ("user" privs, not "owner"),
 > > and MS-DOS FS support in the kernel used for the build.
 > > 
 > 
 > No, it doesn't (if you have SYSLINUX 2.02 or higher.)

Cool. The one in RedHat 8 must be pretty old then.
I'll grab the latest and give it a try.

/Mikael
