Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317288AbSFCGJJ>; Mon, 3 Jun 2002 02:09:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317290AbSFCGJI>; Mon, 3 Jun 2002 02:09:08 -0400
Received: from mail.zmailer.org ([62.240.94.4]:5320 "EHLO mail.zmailer.org")
	by vger.kernel.org with ESMTP id <S317288AbSFCGJH>;
	Mon, 3 Jun 2002 02:09:07 -0400
Date: Mon, 3 Jun 2002 09:09:07 +0300
From: Matti Aarnio <matti.aarnio@zmailer.org>
To: Colin Foran <nathantwist@attbi.com>
Cc: Andrew Gierth <andrew@erlenstar.demon.co.uk>, linux-kernel@vger.kernel.org
Subject: Re: Wrote a server, but telnet can't connect
Message-ID: <20020603090907.R18899@mea-ext.zmailer.org>
In-Reply-To: <24fda70e.0206021107.1222101f@posting.google.com> <87ofetwjxd.fsf@erlenstar.demon.co.uk> <3CFABCF0.B39687AC@attbi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 02, 2002 at 08:48:48PM -0400, Colin Foran wrote:
> thanks Andrew, really appreciate the interest.
> I've changed the program as youve suggested, and even done away with 
> the error checking altogether, but Telnet still gets timed out. dont
> suppose youve seen anything else that might trip it up?

  Perhaps your machine has some built-in firewall ?

  E.g. picking lattest RedHat and answering "strict security" into
  default-firewall building question in the installation tool will
  cause this kind of problems.

> Again, thanks for the interest
> Cheers

/Matti Aarnio
