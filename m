Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281465AbRKFECv>; Mon, 5 Nov 2001 23:02:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281464AbRKFECm>; Mon, 5 Nov 2001 23:02:42 -0500
Received: from zero.tech9.net ([209.61.188.187]:25871 "EHLO zero.tech9.net")
	by vger.kernel.org with ESMTP id <S281453AbRKFECf>;
	Mon, 5 Nov 2001 23:02:35 -0500
Subject: Re: kernel 2.4.14 compiling fail for loop device
From: Robert Love <rml@tech9.net>
To: Mike Fedyk <mfedyk@matchmail.com>
Cc: Terminator <jimmy@mtc.dhs.org>, linux-kernel@vger.kernel.org
In-Reply-To: <20011105194316.B665@mikef-linux.matchmail.com>
In-Reply-To: <Pine.LNX.4.33.0111051936090.18663-100000@www.mtc.dhs.org> 
	<20011105194316.B665@mikef-linux.matchmail.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.16.100+cvs.2001.11.05.15.31 (Preview Release)
Date: 05 Nov 2001 23:02:36 -0500
Message-Id: <1005019360.897.2.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2001-11-05 at 22:43, Mike Fedyk wrote:
> Did anyone have this problem with pre8???

Nope, it was added post-pre8 to final.  The deactivate_page function was
removed completely.

	Robert Love

