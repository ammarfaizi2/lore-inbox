Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261356AbTAaPHD>; Fri, 31 Jan 2003 10:07:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261364AbTAaPHD>; Fri, 31 Jan 2003 10:07:03 -0500
Received: from noodles.codemonkey.org.uk ([213.152.47.19]:41690 "EHLO
	noodles.internal") by vger.kernel.org with ESMTP id <S261356AbTAaPHD>;
	Fri, 31 Jan 2003 10:07:03 -0500
Date: Fri, 31 Jan 2003 15:12:24 +0000
From: Dave Jones <davej@codemonkey.org.uk>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: John Bradford <john@grabjohn.com>, Tomas Szepe <szepe@pinerecords.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       arodland@noln.com
Subject: Re: [PATCH] 2.5.59 morse code panics
Message-ID: <20030131151224.GB15332@codemonkey.org.uk>
Mail-Followup-To: Dave Jones <davej@codemonkey.org.uk>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>,
	John Bradford <john@grabjohn.com>,
	Tomas Szepe <szepe@pinerecords.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	arodland@noln.com
References: <20030131104326.GF12286@louise.pinerecords.com> <200301311112.h0VBCv00000575@darkstar.example.net> <20030131132221.GA12834@codemonkey.org.uk> <1044025785.1654.13.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1044025785.1654.13.camel@irongate.swansea.linux.org.uk>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 31, 2003 at 03:09:46PM +0000, Alan Cox wrote:

 > A lot of newer laptops do not have serial ports.

so use something sensible like a crashdump to floppy.
 
 > While morse code may
 > be a little silly the general purpose hook  it needs to be done 
 > cleanly is considerably more useful

sure. things like lkcd,netconsole etc could all use that
infrastructure.   The beyond-silly bit was the 'other machine
to decode morse' argument.

		Dave

-- 
| Dave Jones.        http://www.codemonkey.org.uk
