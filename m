Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129884AbRCGC6c>; Tue, 6 Mar 2001 21:58:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129915AbRCGC6N>; Tue, 6 Mar 2001 21:58:13 -0500
Received: from sgi.SGI.COM ([192.48.153.1]:39273 "EHLO sgi.com")
	by vger.kernel.org with ESMTP id <S129884AbRCGC6C>;
	Tue, 6 Mar 2001 21:58:02 -0500
Message-ID: <3AA5A333.4DF8A096@sgi.com>
Date: Tue, 06 Mar 2001 18:55:47 -0800
From: Rajagopal Ananthanarayanan <ananth@sgi.com>
X-Mailer: Mozilla 4.72 [en] (X11; U; Linux 2.2.16-4SGI_20smp i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Jeff Dike <jdike@karaya.com>, linux-kernel@vger.kernel.org
CC: sfoehner@sgi.com
Subject: Re: kernel lock contention and scalability
In-Reply-To: <98454d$19p9h$1@fido.engr.sgi.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Dike wrote:
	[ ... ]
> 
> > Another synchronization method popular with database peeps is "post/
> > wait" for which SGI have a patch available for Linux. I understand
> > that this is relatively "light weight" and might be a better choice
> > for PG.
> 
> URL?
> 
>                                 Jeff


Here it is:

	http://oss.sgi.com/projects/postwait/

Check out the download section for a 2.4.0 patch.

cheers,

ananth.

--------------------------------------------------------------------------
Rajagopal Ananthanarayanan ("ananth")
Member Technical Staff, SGI.
--------------------------------------------------------------------------
