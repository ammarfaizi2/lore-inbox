Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264289AbRFMXkA>; Wed, 13 Jun 2001 19:40:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264291AbRFMXjt>; Wed, 13 Jun 2001 19:39:49 -0400
Received: from roc-24-169-102-121.rochester.rr.com ([24.169.102.121]:60176
	"EHLO roc-24-169-102-121.rochester.rr.com") by vger.kernel.org
	with ESMTP id <S264289AbRFMXjq>; Wed, 13 Jun 2001 19:39:46 -0400
Date: Wed, 13 Jun 2001 19:39:03 -0400
From: Chris Mason <mason@suse.com>
To: Larry McVoy <lm@bitmover.com>, linux-kernel@vger.kernel.org
Subject: Re: 2.4.5 data corruption
Message-ID: <244140000.992475543@tiny>
In-Reply-To: <200106122017.f5CKHnf24565@work.bitmover.com>
X-Mailer: Mulberry/2.0.8 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tuesday, June 12, 2001 01:17:49 PM -0700 Larry McVoy <lm@bitmover.com>
wrote:

> Folks, I believe I have a reproducible test case which corrupts data in
> 2.4.5.
> 
> We do nightly, weekly, and monthly backups by copying our entire /home
> partition on the company file server:
> 
> Filesystem            Size  Used Avail Use% Mounted on
> /dev/hda1             1.9G  1.7G  123M  93% /
> /dev/hda6             1.9G  437M  1.4G  23% /tmp

What flavor of IDE controller?  Where is swap?

-chris

