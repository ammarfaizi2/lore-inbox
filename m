Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265132AbSLHDUg>; Sat, 7 Dec 2002 22:20:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265134AbSLHDUg>; Sat, 7 Dec 2002 22:20:36 -0500
Received: from louise.pinerecords.com ([213.168.176.16]:60932 "EHLO
	louise.pinerecords.com") by vger.kernel.org with ESMTP
	id <S265132AbSLHDUf>; Sat, 7 Dec 2002 22:20:35 -0500
Date: Sun, 8 Dec 2002 04:28:09 +0100
From: Tomas Szepe <szepe@pinerecords.com>
To: lkml <linux-kernel@vger.kernel.org>
Cc: "Trever L. Adams" <tadams-lists@myrealbox.com>,
       David Ashley <dash@xdr.com>
Subject: Re: 2.4.18 beats 2.5.50 in hard drive access????
Message-ID: <20021208032809.GO32065@louise.pinerecords.com>
References: <200212062300.gB6N0jg10757@xdr.com> <1039227036.25004.0.camel@irongate.swansea.linux.org.uk> <1039235352.3232.22.camel@aurora.localdomain> <1039312542.27904.15.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1039312542.27904.15.camel@irongate.swansea.linux.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> The DMA off is just a bit of excess noise in the IDE code - the VIA
> driver turns DMA back on again.

http://marc.theaimsgroup.com/?l=linux-kernel&m=103873530021488&w=2

-- 
Tomas Szepe <szepe@pinerecords.com>
