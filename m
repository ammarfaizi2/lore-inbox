Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263102AbTJJTR3 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Oct 2003 15:17:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263106AbTJJTR2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Oct 2003 15:17:28 -0400
Received: from logic.net ([64.81.146.141]:36763 "EHLO logic.net")
	by vger.kernel.org with ESMTP id S263102AbTJJTRW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Oct 2003 15:17:22 -0400
Date: Fri, 10 Oct 2003 14:17:21 -0500
From: esm@logic.net
To: Ivo Palli <ivo@palli.nl>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Linux kernel GPL violation (EasyRDP)
Message-ID: <20031010191721.GB2862@talus.logic.net>
References: <3F86FF16.6010006@palli.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3F86FF16.6010006@palli.nl>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 10, 2003 at 08:48:54PM +0200, Ivo Palli wrote:
> A complete description and dissection of the product can be found on my 
> website: http://www.palli.nl/~ivo/rdp/

Just FYI: you can get at the useful bits of all of this without agreeing
to any license (which I haven't even seen; I don't have a Windows system
handy right now). I assumed the .img file was just a raw image of a floppy,
so a quick:

    mkdir /tmp/foo
    mount -o loop,ro easyRDP_v3_0.img /tmp/foo

does the trick for getting at the contents.

-- 
Edward S. Marshall <esm@logic.net>
http://esm.logic.net/

Felix qui potuit rerum cognoscere causas.
