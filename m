Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130225AbQLITtN>; Sat, 9 Dec 2000 14:49:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130344AbQLITtD>; Sat, 9 Dec 2000 14:49:03 -0500
Received: from vger.timpanogas.org ([207.109.151.240]:19462 "EHLO
	vger.timpanogas.org") by vger.kernel.org with ESMTP
	id <S130225AbQLITs4>; Sat, 9 Dec 2000 14:48:56 -0500
Date: Sat, 9 Dec 2000 13:14:08 -0700
From: "Jeff V. Merkey" <jmerkey@vger.timpanogas.org>
To: "Steven N. Hirsch" <shirsch@adelphia.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.2.18-25 and PS/2 Mouse
Message-ID: <20001209131408.A13853@vger.timpanogas.org>
In-Reply-To: <20001208212929.A10469@vger.timpanogas.org> <Pine.LNX.4.21.0012091005010.3459-100000@pii.fast.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <Pine.LNX.4.21.0012091005010.3459-100000@pii.fast.net>; from shirsch@adelphia.net on Sat, Dec 09, 2000 at 10:05:46AM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 09, 2000 at 10:05:46AM -0500, Steven N. Hirsch wrote:
> On Fri, 8 Dec 2000, Jeff V. Merkey wrote:
> 
> > The mouse problems have gone away with the 2.2.18-25 pre-patch.  I 
> > am not seeing the problems anymore on the affected systems.  I am
> > trying this evening to apply the 2.4 patch sent to me to see if it
> > helps with the page cache corruption problem with fork().
> 
> Phantom PS/2 mouse still detected on my ASUS P2B-DS system board w/ pre25.

Looks like there's still a problem.

> 
> 
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
