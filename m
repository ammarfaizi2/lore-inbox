Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261852AbTGAJnc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Jul 2003 05:43:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261872AbTGAJnb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Jul 2003 05:43:31 -0400
Received: from mail018.syd.optusnet.com.au ([210.49.20.176]:56220 "EHLO
	mail018.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S261852AbTGAJnb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Jul 2003 05:43:31 -0400
Date: Tue, 1 Jul 2003 19:56:23 +1000
To: "Henning P. Schmiedehausen" <hps@intermeta.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: File System conversion -- ideas
Message-ID: <20030701095623.GA3587@cancer>
References: <200306291011.h5TABQXB000391@81-2-122-30.bradfords.org.uk> <20030629132807.GA25170@mail.jlokier.co.uk> <3EFEEEC3.30505@sktc.net> <bdpn3c$te5$1@tangens.hometree.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bdpn3c$te5$1@tangens.hometree.net>
User-Agent: Mutt/1.5.4i
From: Stewart Smith <stewart@linux.org.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 30, 2003 at 04:05:00PM +0000, Henning P. Schmiedehausen wrote:
> You have a 6 GB file. You lose. :-)

funny how people can get their head around partially downloaded files, but not around partial files on a disk.

copy 5GB first, resize, then the next gig. easy. (well, relatively).

Sure, you could crash and end up with 2 halves - which a 'cat' would fix!

-- 
Stewart Smith
Vice President, Linux Australia
http://www.linux.org.au (personal: http://www.flamingspork.com)
