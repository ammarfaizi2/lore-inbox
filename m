Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263766AbTEFOCm (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 May 2003 10:02:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263729AbTEFOBe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 May 2003 10:01:34 -0400
Received: from windsormachine.com ([206.48.122.28]:522 "EHLO
	router.windsormachine.com") by vger.kernel.org with ESMTP
	id S263730AbTEFOBJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 May 2003 10:01:09 -0400
Date: Tue, 6 May 2003 10:13:38 -0400 (EDT)
From: Mike Dresser <mdresser_l@windsormachine.com>
To: <linux-kernel@vger.kernel.org>
Subject: Re: ISDN massive packet drops while DVD burn/verify
In-Reply-To: <1052225795.1201.11.camel@dhcp22.swansea.linux.org.uk>
Message-ID: <Pine.LNX.4.33.0305061006560.20527-100000@router.windsormachine.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 6 May 2003, Alan Cox wrote:

> Except for certain operations like audio cd ripping

Burning audio cd's too, right?

I've noticed that burnfree gets triggered quite often while burning audio
cd's on my LiteOn LTR-48125W at 40x(maximum my cds will let me do).

Actually, speaking of that, I'm using burnfree under cdrecord 2.01a10.
Once in awhile I'll burn a cd and the red light turns to orange, indicating
burnproof has triggered on the drive.

Yet, at the end of the burn using -v, cdrecord will claim burnfree was
never needed even though it has triggered dozens of times.

Very weird.

Mike

