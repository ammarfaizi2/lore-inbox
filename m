Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263927AbTLELYX (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Dec 2003 06:24:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263923AbTLELYW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Dec 2003 06:24:22 -0500
Received: from mail.fh-wedel.de ([213.39.232.194]:61144 "EHLO mail.fh-wedel.de")
	by vger.kernel.org with ESMTP id S263922AbTLELYS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Dec 2003 06:24:18 -0500
Date: Fri, 5 Dec 2003 12:20:50 +0100
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: Erez Zadok <ezk@cs.sunysb.edu>
Cc: Phillip Lougher <phillip@lougher.demon.co.uk>,
       Kallol Biswas <kbiswas@neoscale.com>, linux-kernel@vger.kernel.org,
       "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: Re: partially encrypted filesystem
Message-ID: <20031205112050.GA29975@wohnheim.fh-wedel.de>
References: <3FCF7AD5.4050501@lougher.demon.co.uk> <200312041941.hB4Jfm0E008607@agora.fsl.cs.sunysb.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <200312041941.hB4Jfm0E008607@agora.fsl.cs.sunysb.edu>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 4 December 2003 14:41:48 -0500, Erez Zadok wrote:
> 
> Part of our stackable f/s project (FiST) includes a Gzipfs stackable
> compression f/s.  There was a paper on it in Usenix 2001 and there's code in
> the latest fistgen package.  See
> http://www1.cs.columbia.edu/~ezk/research/fist/
> 
> Performance of Gzipfs is another matter, esp. for writes in the middle of
> files. :-)

You don't seriously treat big files as a single gzip stream, do you?
;)

Jörn

-- 
Geld macht nicht glücklich.
Glück macht nicht satt.
