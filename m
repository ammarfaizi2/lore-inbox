Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265351AbSLVUxt>; Sun, 22 Dec 2002 15:53:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265373AbSLVUxt>; Sun, 22 Dec 2002 15:53:49 -0500
Received: from smtp.comcast.net ([24.153.64.2]:50046 "EHLO smtp.comcast.net")
	by vger.kernel.org with ESMTP id <S265351AbSLVUxs>;
	Sun, 22 Dec 2002 15:53:48 -0500
Date: Sun, 22 Dec 2002 16:07:00 -0500
From: Joshua Stewart <joshua.stewart@comcast.net>
Subject: Re: A little explanation needed
In-reply-to: <20021222053501.GC17133@kroah.com>
To: Greg KH <greg@kroah.com>
Cc: linux-kernel@vger.kernel.org
Message-id: <1040591221.11603.1.camel@localhost.localdomain>
MIME-version: 1.0
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10)
Content-type: text/plain
Content-transfer-encoding: 7BIT
References: <1040535392.1518.3.camel@localhost.localdomain>
 <20021222053501.GC17133@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for the help.  It all makes perfect sense after thinking about it
from a preprecessor point of view.  I'm just not used to using so many
macros and so I don't realize all the implications of preprocessing
quite yet.  But, I'm learning.

Josh

On Sun, 2002-12-22 at 00:35, Greg KH wrote:
> On Sun, Dec 22, 2002 at 12:36:32AM -0500, Joshua Stewart wrote:
> > 
> > In otherwords, what's the use of a do{X}while(0) "loop" instead of just
> > X.  I'm not the world's best trained C programmer, so forgive me if I
> > sound stupid.
> 
> http://www.kernelnewbies.org/faq/index.php3#dowhile
> 
> Hope that helps,
> 
> greg k-h
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/


