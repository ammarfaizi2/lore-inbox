Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130290AbRBHLlv>; Thu, 8 Feb 2001 06:41:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131074AbRBHLll>; Thu, 8 Feb 2001 06:41:41 -0500
Received: from mail2.uni-bielefeld.de ([129.70.4.90]:32310 "EHLO
	mail.uni-bielefeld.de") by vger.kernel.org with ESMTP
	id <S130290AbRBHLld>; Thu, 8 Feb 2001 06:41:33 -0500
Date: Thu, 08 Feb 2001 12:44:22 +0100
From: Marc Mutz <Marc@Mutz.com>
Subject: Re: Status of loopback
In-Reply-To: <3A81996C.3060600@lycosmail.com>
To: Adam Schrotenboer <ajschrotenboer@lycosmail.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Message-id: <01020812442200.17764@dirichlet.mathematik.uni-bielefeld.de>
Organization: Bielefeld University - Dep. of Mathematics / Dep. of Physics
MIME-version: 1.0
X-Mailer: KMail [version 1.2]
Content-type: text/plain; charset=iso-8859-1
Content-transfer-encoding: 7BIT
In-Reply-To: <3A81996C.3060600@lycosmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 07 February 2001 19:52, Adam Schrotenboer wrote:
> I'm curious if the loopback block driver is stable enough yet to, say
> put a loopback file on a vfat partition.
<snip>

Don't try w/o the loop-4 patch by jens 
(ftp://ftp.kernel.org/pub/linux/kernel/people/axboe/patches/)

Marc

-- 
Marc Mutz <Marc@Mutz.com>
o http://marc.mutz.com (homepage)
o http://www.mathematik.uni-bielefeld.de/~mmutz/ (maths)
o http://EncryptionHOWTO.sourceforge.net
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
