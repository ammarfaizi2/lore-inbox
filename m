Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315536AbSGYUUA>; Thu, 25 Jul 2002 16:20:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315946AbSGYUUA>; Thu, 25 Jul 2002 16:20:00 -0400
Received: from hq.fsmlabs.com ([209.155.42.197]:967 "EHLO hq.fsmlabs.com")
	by vger.kernel.org with ESMTP id <S315536AbSGYUUA>;
	Thu, 25 Jul 2002 16:20:00 -0400
From: Cort Dougan <cort@fsmlabs.com>
Date: Thu, 25 Jul 2002 14:16:21 -0600
To: Benjamin LaHaise <bcrl@redhat.com>
Cc: Christoph Hellwig <hch@infradead.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cheap lookup of symbol names on oops()
Message-ID: <20020725141621.M2276@host110.fsmlabs.com>
References: <20020725110033.G2276@host110.fsmlabs.com> <20020725181126.A17859@infradead.org> <20020725112142.I2276@host110.fsmlabs.com> <20020725144913.E8839@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20020725144913.E8839@redhat.com>; from bcrl@redhat.com on Thu, Jul 25, 2002 at 02:49:13PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nearly all of the code scattered through arch/ppc uses the Cort indention
style, it hasn't done any damage.  I don't think a 50 line patch is going
to drag Linux down into the mudpits because of an extra \n.  If the
indention is an issue it can be quickly changed when it's applied.

Aunt Tillie is, after all, a non-coder.  She was just barely able to
configure the kernel thanks to CML2.  If Penelope hadn't been helped out by
the creepy guy and the good looking guy she wouldn't even have started
emacs.

As for myself, I think 50 locking primitives are spurious but a couple
extra whitespace chars are just a minor issue :)

} It looks like she still has to ready the Documentation/CodingStyle.  The 
} space after the ( and before the ) are spurious, and thes { belongs on 
} the same line as the if.
