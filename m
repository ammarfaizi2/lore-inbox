Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268296AbTCCCWi>; Sun, 2 Mar 2003 21:22:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268308AbTCCCWi>; Sun, 2 Mar 2003 21:22:38 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:38161 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S268296AbTCCCWh>;
	Sun, 2 Mar 2003 21:22:37 -0500
Message-ID: <3E62BED0.8040204@pobox.com>
Date: Sun, 02 Mar 2003 21:32:48 -0500
From: Jeff Garzik <jgarzik@pobox.com>
Organization: none
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20021213 Debian/1.2.1-2.bunk
X-Accept-Language: en
MIME-Version: 1.0
To: nickn <nickn@www0.org>
CC: "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
Subject: Re: BitBucket: GPL-ed *notrademarkhere* clone
References: <200303020011.QAA13450@adam.yggdrasil.com> <3E615C38.7030609@pobox.com> <20030302014039.GC1364@dualathlon.random> <3E616224.6040003@pobox.com> <b3rtr2$rmg$1@cesium.transmeta.com> <3E623B9A.8050405@pobox.com> <20030303004728.GA5856@www0.org>
In-Reply-To: <20030303004728.GA5856@www0.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

nickn wrote:
> On Sun, Mar 02, 2003 at 12:12:58PM -0500, Jeff Garzik wrote:
> 
>>My counter-question is, why not improve an _existing_ open source SCM to 
>>read and write BitKeeper files?  Why do we need yet another brand new 
>>project?
> 
> 
> Or improve BK to export and import on demand of an existing open source SCM.


That may be possible with OpenCM, but it's a bit of a stretch for the 
other existing SCMs.  Regardless, if BK can export metadata to an open 
format (such as a defined XML spec), then the SCM interchange 
possibilities are only limited by a programmer's time and imagination.

	Jeff



