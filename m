Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267158AbTAaOFT>; Fri, 31 Jan 2003 09:05:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267189AbTAaOFT>; Fri, 31 Jan 2003 09:05:19 -0500
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:13450
	"EHLO irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S267158AbTAaOFT>; Fri, 31 Jan 2003 09:05:19 -0500
Subject: Re: [PATCH] 2.5.59 morse code panics
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Dave Jones <davej@codemonkey.org.uk>
Cc: John Bradford <john@grabjohn.com>, Tomas Szepe <szepe@pinerecords.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       arodland@noln.com
In-Reply-To: <20030131132221.GA12834@codemonkey.org.uk>
References: <20030131104326.GF12286@louise.pinerecords.com>
	 <200301311112.h0VBCv00000575@darkstar.example.net>
	 <20030131132221.GA12834@codemonkey.org.uk>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1044025785.1654.13.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 (1.2.1-2) 
Date: 31 Jan 2003 15:09:46 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2003-01-31 at 13:22, Dave Jones wrote:
> Or you could put down the crackpipe and run a serial console between
> the two boxes. Or even netconsole would make more sense
> (and be a lot more reliable).

A lot of newer laptops do not have serial ports. While morse code may
be a little silly the general purpose hook  it needs to be done 
cleanly is considerably more useful

