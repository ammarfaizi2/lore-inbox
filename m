Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129035AbRBBJ5o>; Fri, 2 Feb 2001 04:57:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129070AbRBBJ5e>; Fri, 2 Feb 2001 04:57:34 -0500
Received: from mean.netppl.fi ([195.242.208.16]:6931 "EHLO mean.netppl.fi")
	by vger.kernel.org with ESMTP id <S129035AbRBBJ5T>;
	Fri, 2 Feb 2001 04:57:19 -0500
Date: Fri, 2 Feb 2001 11:57:12 +0200
From: Pekka Pietikainen <pp@evil.netppl.fi>
To: linux-kernel@vger.kernel.org
Subject: Re: spelling of disc (disk) in /devfs
Message-ID: <20010202115712.A31607@netppl.fi>
In-Reply-To: <6lah7t4f685qo3igk679ocdo2obfhd9lvg@4ax.com> <20010201193255.A32191@thune.yy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0pre3i
In-Reply-To: <20010201193255.A32191@thune.yy.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 01, 2001 at 07:32:55PM -0800, Mike Castle wrote:
> On Thu, Feb 01, 2001 at 12:19:56AM +0000, Alan Chandler wrote:
> > I now find myself confused with the new approach.
> 
> try "man -k disc" and compare the output with "man -k disk"
> 
> Since nearly all of the utilities refer to "disk" rather than "disc," it
> would make more since to be consistent with that.

<sarcasm>
What we really need is the ability to 
echo en_US/en_GB > /proc/sys/kernel/locale so you can choose
the one you want.
</sarcasm>

-- 
Pekka Pietikainen
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
