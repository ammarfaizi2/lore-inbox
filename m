Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317633AbSGOX1P>; Mon, 15 Jul 2002 19:27:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317695AbSGOX1O>; Mon, 15 Jul 2002 19:27:14 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:763 "EHLO
	hermes.mvista.com") by vger.kernel.org with ESMTP
	id <S317633AbSGOX1N>; Mon, 15 Jul 2002 19:27:13 -0400
Subject: Re: Linux 2.4.19-rc1-ac5
From: Robert Love <rml@tech9.net>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
In-Reply-To: <3D335903.6000603@zytor.com>
References: <200207152148.g6FLm7Q24750@devserv.devel.redhat.com>	<20020715220241Z317668-
	 685+9887@vger.kernel.org> 	<agvl00$jjm$1@cesium.transmeta.com>
	<1026779299.32689.46.camel@irongate.swansea.linux.org.uk> 
	<3D335903.6000603@zytor.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 
Date: 15 Jul 2002 16:29:20 -0700
Message-Id: <1026775760.1093.508.camel@sinai>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2002-07-15 at 16:21, H. Peter Anvin wrote:

> Hmmm...
> 
> This bothers me somewhat, because a .bz2 file should not have been
> created if the .gz file was corrupt, but the original poster strongly
> implied that he had both the .gz file and a .bz2 file, unless your
> update came in between.

No, I think the bzip2 was not created while the gzip file was corrupt.

Earlier, there was a corrupt gzip and no bzip2 file.

Then I guess Alan fixed it, and now there exists both a valid gzip and
bzip2 file.  So I think your stuff is working fine :)

	Robert Love

