Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265898AbTBTQfs>; Thu, 20 Feb 2003 11:35:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265936AbTBTQfs>; Thu, 20 Feb 2003 11:35:48 -0500
Received: from havoc.daloft.com ([64.213.145.173]:7061 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id <S265898AbTBTQfr>;
	Thu, 20 Feb 2003 11:35:47 -0500
Date: Thu, 20 Feb 2003 11:45:47 -0500
From: Jeff Garzik <jgarzik@pobox.com>
To: Steven French <sfrench@us.ibm.com>
Cc: Martin Josefsson <gandalf@wlug.westbo.se>, linux-kernel@vger.kernel.org
Subject: Re: cifs leaks memory like crazy in 2.5.61
Message-ID: <20030220164547.GB9800@gtf.org>
References: <OF566C3F49.C8CA5594-ON87256CD3.0058B0B3@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <OF566C3F49.C8CA5594-ON87256CD3.0058B0B3@us.ibm.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 20, 2003 at 10:28:07AM -0600, Steven French wrote:
> Hadn't run into this - I had been focusing on the readahead and write page
> improvements (which have improved especially write performance
> spectacularly) and also have just fixed a problem with redundant lookups of
> directory inodes but had not been doing readdir (cifs
> Trans2FindFirst/Trans2FindNext) testing recently.  I just did - and the

Well, here is a humble request to actually test your stuff,
before adding more features!

	Jeff



