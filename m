Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261892AbRESQgr>; Sat, 19 May 2001 12:36:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261887AbRESQgi>; Sat, 19 May 2001 12:36:38 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:22001 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S261875AbRESQgc> convert rfc822-to-8bit;
	Sat, 19 May 2001 12:36:32 -0400
Date: Sat, 19 May 2001 12:36:30 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Ben LaHaise <bcrl@redhat.com>, Andrew Morton <andrewm@uow.edu.au>,
        Andries.Brouwer@cwi.nl, torvalds@transmeta.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFD w/info-PATCH] device arguments from lookup, partion code
In-Reply-To: <E1519Xe-00005c-00@the-village.bc.nu>
Message-ID: <Pine.GSO.4.21.0105191230130.5339-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=KOI8-R
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 19 May 2001, Alan Cox wrote:

> > Now that I'm awake and refreshed, yeah, that's awful.  But
> > echo "hot-add,slot=5,device=/dev/sda" >/dev/md0/control *is* sane.  Heck,
> > the system can even send back result codes that way.
> 
> Only to an English speaker. I suspect Quebec City canadians would prefer a
> different command set.

Alan, I'm not a native speaker and I had worked with system that got names
of utilities translated to Russian.

It's was hell. And I don't think that replacing compress (or пакуй) with
42A1769 would make it better.

