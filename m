Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129406AbRAJURz>; Wed, 10 Jan 2001 15:17:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129431AbRAJURp>; Wed, 10 Jan 2001 15:17:45 -0500
Received: from mail.sun.ac.za ([146.232.128.1]:10251 "EHLO mail.sun.ac.za")
	by vger.kernel.org with ESMTP id <S129406AbRAJURi>;
	Wed, 10 Jan 2001 15:17:38 -0500
Date: Wed, 10 Jan 2001 22:17:24 +0200 (SAST)
From: Hans Grobler <grobh@sun.ac.za>
To: Nathan Walp <faceprint@faceprint.com>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: Oops in 2.4.0-ac5
In-Reply-To: <3A5CBF57.1E89DD35@faceprint.com>
Message-ID: <Pine.LNX.4.30.0101102212290.30013-100000@prime.sun.ac.za>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 10 Jan 2001, Nathan Walp wrote:
> First post to the list, hope I get this right...

Could you please run this through ksymoops on your machine.
Depending on which distribution you're using, this can be as
simple as:

  ksymoops <  oops.txt

Remember to set the System.map to the correct one, if you did
not compile in /usr/src/linux.

Thanks,
-- Hans



-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
