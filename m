Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265132AbSJPQCk>; Wed, 16 Oct 2002 12:02:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265145AbSJPQCk>; Wed, 16 Oct 2002 12:02:40 -0400
Received: from [198.149.18.6] ([198.149.18.6]:11414 "EHLO tolkor.sgi.com")
	by vger.kernel.org with ESMTP id <S265132AbSJPQCk>;
	Wed, 16 Oct 2002 12:02:40 -0400
Date: Wed, 16 Oct 2002 19:21:43 -0400
From: Christoph Hellwig <hch@sgi.com>
To: Miles Bader <miles@gnu.org>
Cc: jw schultz <jw@pegasys.ws>, linux-kernel@vger.kernel.org
Subject: Re: mapping 36 bit physical addresses into 32 bit virtual
Message-ID: <20021016192143.B22932@sgi.com>
Mail-Followup-To: Christoph Hellwig <hch@sgi.com>,
	Miles Bader <miles@gnu.org>, jw schultz <jw@pegasys.ws>,
	linux-kernel@vger.kernel.org
References: <20021015165947.50642.qmail@web13801.mail.yahoo.com> <aoi6bb$309$1@cesium.transmeta.com> <20021016072345.GE7844@pegasys.ws> <buo4rbmvlq8.fsf@mcspd15.ucom.lsi.nec.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <buo4rbmvlq8.fsf@mcspd15.ucom.lsi.nec.co.jp>; from miles@lsi.nec.co.jp on Wed, Oct 16, 2002 at 05:20:15PM +0900
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 16, 2002 at 05:20:15PM +0900, Miles Bader wrote:
> jw schultz <jw@pegasys.ws> writes:
> > i distinctly remember the working with the newest R400x in 1993 which
> > was still 32bit.  I know MIPS went to 64bit sometime not too long
> > after that (mid 90's?) but by then Alpha and Sparc had beaten them to
> > the punch.
> 
> You're wrong -- the R4000 was absolutely 64-bit, and was released in
> 1991.  The 64-bit sparc was circa '93, and alpha I dunno, but I think
> '91-'92.

The 64bit mode of the original r4k was so buggy that you couldn't use
it in practice..

