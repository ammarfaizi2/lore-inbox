Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266521AbUHIMPB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266521AbUHIMPB (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Aug 2004 08:15:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266511AbUHIMNK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Aug 2004 08:13:10 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:51100 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S266508AbUHIMMw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Aug 2004 08:12:52 -0400
Date: Mon, 9 Aug 2004 14:12:23 +0200
From: Jens Axboe <axboe@suse.de>
To: Stephan von Krawczynski <skraw@ithnet.com>
Cc: Joerg Schilling <schilling@fokus.fraunhofer.de>,
       James.Bottomley@steeleye.com, linux-kernel@vger.kernel.org
Subject: Re: PATCH: cdrecord: avoiding scsi device numbering for ide devices
Message-ID: <20040809121222.GH10418@suse.de>
References: <200408091013.i79ADQK0008995@burner.fokus.fraunhofer.de> <20040809140426.142dc4eb.skraw@ithnet.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040809140426.142dc4eb.skraw@ithnet.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 09 2004, Stephan von Krawczynski wrote:
> > AGAIN: if you believe you did invent a better method, _describe_ it.
> > As you did not describe a _working_ method different from the one I request,
> > you need to agree that you are wrong - as long as your description is
> > missing.
> 
> You obviously did not get the basics of the whole story, did you? I really
> wonder how you came this far.
> _You_ are writing code that should be - according to _your_ idea - platform
> independent. If you do something like this it is most obvious that your code
> falls mainly into two pieces: 
> a) platform-independent code
> b) glue code to the specific host/platform
> You have full control over a) and certain unbreakable external requirements for
> b).
> Listening to your posts makes me wonder what your intention really is. Linux

Joergs intentions are just as clear as ever - he would much much rather
bash linux than fix whatever issues there might be with it, because if
they get fixed, he would have nothing else to complain about. It's
ironic that Linux is most likely his largest user base.

-- 
Jens Axboe

