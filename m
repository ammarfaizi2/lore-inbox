Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281341AbRKMEGc>; Mon, 12 Nov 2001 23:06:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281277AbRKMEGW>; Mon, 12 Nov 2001 23:06:22 -0500
Received: from mail315.mail.bellsouth.net ([205.152.58.175]:19158 "EHLO
	imf15bis.bellsouth.net") by vger.kernel.org with ESMTP
	id <S281341AbRKMEGD>; Mon, 12 Nov 2001 23:06:03 -0500
Message-ID: <3BF09C16.A64FC57E@mandrakesoft.com>
Date: Mon, 12 Nov 2001 23:05:42 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.14 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Richard Gooch <rgooch@ras.ucalgary.ca>
CC: John Levon <moz@compsoc.man.ac.uk>, linux-kernel@vger.kernel.org,
        kaos@ocs.com.au
Subject: Re: GPLONLY kernel symbols???
In-Reply-To: <Pine.LNX.4.33.0110160927030.24895-100000@devel.office>
		<30375.1003285059@kao2.melbourne.sgi.com>
		<20011017151534.B91069@compsoc.man.ac.uk> <200111130257.fAD2vZt15653@vindaloo.ras.ucalgary.ca>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Richard Gooch wrote:
> BTW: I had to edit after applying your patch: it didn't conform to the
> Style[tm].

Dude.  Really.  Have you actually read CodingStyle?  No joke, I hear
complaints about your code formatting from several [non-viro :):)]
sources.

The practice of non-standard indentation and non-standard "if"
formatting -really- makes the code hard to read.

Is there a good reason why your code is vehemently different from
CodingStyle?

	Jeff


-- 
Jeff Garzik      | Only so many songs can be sung
Building 1024    | with two lips, two lungs, and one tongue.
MandrakeSoft     |         - nomeansno

