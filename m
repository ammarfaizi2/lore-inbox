Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263283AbVGAIoZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263283AbVGAIoZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Jul 2005 04:44:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263284AbVGAIoZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Jul 2005 04:44:25 -0400
Received: from rwcrmhc14.comcast.net ([216.148.227.89]:44224 "EHLO
	rwcrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S263283AbVGAIoW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Jul 2005 04:44:22 -0400
Message-ID: <42C5026C.20807@namesys.com>
Date: Fri, 01 Jul 2005 01:44:28 -0700
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.5) Gecko/20041217
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: David Masover <ninja@slaphack.com>
CC: Hubert Chan <hubert@uhoreg.ca>, Ross Biro <ross.biro@gmail.com>,
       Horst von Brand <vonbrand@inf.utfsm.cl>,
       Kyle Moffett <mrmacman_g4@mac.com>, Valdis.Kletnieks@vt.edu,
       Lincoln Dale <ltd@cisco.com>, Gregory Maxwell <gmaxwell@gmail.com>,
       Jeff Garzik <jgarzik@pobox.com>, Christoph Hellwig <hch@infradead.org>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       ReiserFS List <reiserfs-list@namesys.com>
Subject: Re: reiser4 plugins
References: <hubert@uhoreg.ca>	<200506290509.j5T595I6010576@laptop11.inf.utfsm.cl>	<87hdfgvqvl.fsf@evinrude.uhoreg.ca>	<8783be6605062914341bcff7cb@mail.gmail.com> <878y0svj1h.fsf@evinrude.uhoreg.ca> <42C4F97B.1080803@slaphack.com> <42C4FC0E.7010104@namesys.com> <42C4FE70.4020809@slaphack.com>
In-Reply-To: <42C4FE70.4020809@slaphack.com>
X-Enigmail-Version: 0.90.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Masover wrote:

> Hans Reiser wrote:
>
>> It was always the expectation that users would want to have one
>> mountpoint with the files having metafiles as files, and another with
>> the same files but strictly posix, and then their apps can use whichever
>> they have the power to understand.
>
>
> It was never in the early betas I tried :(

Yes, well, there are a lot of things missing in functionality still from
what was, and still is, in the plan.  Inheritance, files not listed by
readdir, etc., lots of things need coding.  We have done the hard stuff
first though, so these other things will mostly not be a lot of code....

Hans

