Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316753AbSERGOd>; Sat, 18 May 2002 02:14:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316756AbSERGOc>; Sat, 18 May 2002 02:14:32 -0400
Received: from smtpnotes.altec.com ([209.149.164.10]:41476 "HELO
	smtpnotes.altec.com") by vger.kernel.org with SMTP
	id <S316753AbSERGOa>; Sat, 18 May 2002 02:14:30 -0400
X-Lotus-FromDomain: ALTEC
From: Wayne.Brown@altec.com
To: linux-kernel@vger.kernel.org
Message-ID: <86256BBD.00223AD9.00@smtpnotes.altec.com>
Date: Sat, 18 May 2002 01:05:40 -0500
Subject: Re: kbuild 2.5 is ready for inclusion in the 2.5 kernel - take 3
Mime-Version: 1.0
Content-type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Someone said here on the list a few months ago that "make bzlilo" was replaced
by "make install" and that it was necessary to configure the "install" option's
behavior.





David Lang <david.lang@digitalinsight.com> on 05/18/2002 12:23:10 AM

To:   Wayne Brown/Corporate/Altec@Altec
cc:   linux-kernel@vger.kernel.org

Subject:  Re: kbuild 2.5 is ready for inclusion in the 2.5 kernel - take 3



Wayne, the only change (other then better, faster functions) is the
elimination of steps.

if it will satisfy you you can continue to do a make mproper and make dep
and just ignore the 'no target found' messages.

David Lang



