Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267641AbTAaNRI>; Fri, 31 Jan 2003 08:17:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267684AbTAaNRI>; Fri, 31 Jan 2003 08:17:08 -0500
Received: from noodles.codemonkey.org.uk ([213.152.47.19]:39897 "EHLO
	noodles.internal") by vger.kernel.org with ESMTP id <S267641AbTAaNRH>;
	Fri, 31 Jan 2003 08:17:07 -0500
Date: Fri, 31 Jan 2003 13:22:21 +0000
From: Dave Jones <davej@codemonkey.org.uk>
To: John Bradford <john@grabjohn.com>
Cc: Tomas Szepe <szepe@pinerecords.com>, alan@lxorguk.ukuu.org.uk,
       linux-kernel@vger.kernel.org, arodland@noln.com
Subject: Re: [PATCH] 2.5.59 morse code panics
Message-ID: <20030131132221.GA12834@codemonkey.org.uk>
Mail-Followup-To: Dave Jones <davej@codemonkey.org.uk>,
	John Bradford <john@grabjohn.com>,
	Tomas Szepe <szepe@pinerecords.com>, alan@lxorguk.ukuu.org.uk,
	linux-kernel@vger.kernel.org, arodland@noln.com
References: <20030131104326.GF12286@louise.pinerecords.com> <200301311112.h0VBCv00000575@darkstar.example.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200301311112.h0VBCv00000575@darkstar.example.net>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 31, 2003 at 11:12:57AM +0000, John Bradford wrote:

 > Actually the Soundblaster idea might not be so funny as it originally
 > sounds, (pun intended :-) ), because if you've got another machine
 > nearby, with a microphone, you could actually turn up the volume, and
 > de-code the morse on the other box.

Or you could put down the crackpipe and run a serial console between
the two boxes. Or even netconsole would make more sense
(and be a lot more reliable).
 
		Dave

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs
