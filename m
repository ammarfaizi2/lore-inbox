Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273545AbRIYWS5>; Tue, 25 Sep 2001 18:18:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273596AbRIYWSr>; Tue, 25 Sep 2001 18:18:47 -0400
Received: from pa147.antoniuk.sdi.tpnet.pl ([213.25.59.147]:51079 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id <S273545AbRIYWSa>; Tue, 25 Sep 2001 18:18:30 -0400
Date: Wed, 26 Sep 2001 00:16:57 +0200
From: Jacek =?iso-8859-2?Q?Pop=B3awski?= <jpopl@interia.pl>
To: linux-kernel@vger.kernel.org
Subject: Re: Burning a CD image slow down my connection
Message-ID: <20010926001657.A6649@localhost.localdomain>
In-Reply-To: <E15loh3-0005PD-00@the-village.bc.nu> <1001412802.1316.4.camel@piccoli>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
User-Agent: Mutt/1.3.17i
In-Reply-To: <1001412802.1316.4.camel@piccoli>; from andy80@ptlug.org on Tue, Sep 25, 2001 at 12:13:16PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 25, 2001 at 12:13:16PM +0200, [A]ndy80 wrote:
> hdparm -c 1 -d 1 -k 1 /dev/hda

"-u 1" helps here (I am connected to Net by serial port)
