Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319034AbSHSVl7>; Mon, 19 Aug 2002 17:41:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319041AbSHSVl6>; Mon, 19 Aug 2002 17:41:58 -0400
Received: from mail12.speakeasy.net ([216.254.0.212]:23758 "EHLO
	mail.speakeasy.net") by vger.kernel.org with ESMTP
	id <S319034AbSHSVl6>; Mon, 19 Aug 2002 17:41:58 -0400
Subject: Re: cerberus errors on 2.4.19 (ide dma related)
From: Ed Sweetman <safemode@speakeasy.net>
To: linux-kernel@vger.kernel.org
In-Reply-To: <1029711302.3331.35.camel@psuedomode>
References: <Pine.GSO.4.21.0208180509540.2495-100000@weyl.math.psu.edu>
	<1029662182.2970.23.camel@psuedomode> <1029694235.520.9.camel@psuedomode>
	<6un0rkuiyg.fsf@zork.zork.net> <1029695363.1357.5.camel@psuedomode>
	<20020818184135.66fe0ba2.arodland@noln.com> 
	<1029711302.3331.35.camel@psuedomode>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 
Date: 19 Aug 2002 17:46:01 -0400
Message-Id: <1029793561.1968.21.camel@psuedomode>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

If the promise controller is unable to function correctly with the VIA
vt82c686b what pci ide controllers are suggested with linux?   And
shouldn't the good-bad ide config disable dma on the promise controller
when used with this chipset or will hdparm in init scripts be required
and fixing the problem be done all in userspace. In which case maybe a
list of hardware conflicts should be included in the help for the
chipset to give some warning.  

