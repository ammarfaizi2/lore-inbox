Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291874AbSBHV7S>; Fri, 8 Feb 2002 16:59:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291871AbSBHV7J>; Fri, 8 Feb 2002 16:59:09 -0500
Received: from adsl-63-194-239-202.dsl.lsan03.pacbell.net ([63.194.239.202]:20217
	"EHLO mmp-linux.matchmail.com") by vger.kernel.org with ESMTP
	id <S291862AbSBHV66>; Fri, 8 Feb 2002 16:58:58 -0500
Date: Fri, 8 Feb 2002 13:59:02 -0800
From: Mike Fedyk <mfedyk@matchmail.com>
To: Anton Altaparmakov <aia21@cam.ac.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Linus' email account is full. - Fwd: Mail System Error - Returned Mail
Message-ID: <20020208215902.GA16065@matchmail.com>
Mail-Followup-To: Anton Altaparmakov <aia21@cam.ac.uk>,
	linux-kernel@vger.kernel.org
In-Reply-To: <5.1.0.14.2.20020208201734.038322c0@pop.cus.cam.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5.1.0.14.2.20020208201734.038322c0@pop.cus.cam.ac.uk>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 08, 2002 at 08:19:15PM +0000, Anton Altaparmakov wrote:
> Linus' email account appears to be full if we can believe this returned 
> email:
> 
> >Envelope-to: aia21@cus.cam.ac.uk
> >To: aia21@cam.ac.uk
> >From: Mail Administrator <Postmaster@transmet.com>
> >Reply-To: Mail Administrator <Postmaster@transmet.com>
> >Subject: Mail System Error - Returned Mail
> >Date: Fri, 8 Feb 2002 15:14:23 -0500
> >
> >This Message was undeliverable due to the following reason:
> >
> >The user(s) account is temporarily over quota.
> >
> ><usr3189@transmet.com>

It looks like the CC in "[RFC] New locking primitive for 2.5" by Martin
Wirth is the culprit.

Once this thread ends, or people change the address manually in their
replies the problem ends.

Mike
