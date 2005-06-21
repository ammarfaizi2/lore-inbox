Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262231AbVFUSsE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262231AbVFUSsE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Jun 2005 14:48:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262232AbVFUSsE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Jun 2005 14:48:04 -0400
Received: from rwcrmhc13.comcast.net ([204.127.198.39]:27283 "EHLO
	rwcrmhc13.comcast.net") by vger.kernel.org with ESMTP
	id S262231AbVFUSr6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Jun 2005 14:47:58 -0400
Message-ID: <42B860D9.60109@namesys.com>
Date: Tue, 21 Jun 2005 11:47:53 -0700
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.5) Gecko/20041217
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Edward Shishkin <edward@namesys.com>
CC: Andrew James Wade 
	<ajwade@cpe00095b3131a0-cm0011ae8cd564.cpe.net.cable.rogers.com>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       reiserfs-dev@namesys.com
Subject: Re: [PATCH] Fix Reiser4 Dependencies
References: <20050619233029.45dd66b8.akpm@osdl.org> <200506200832.22260.ajwade@cpe00095b3131a0-cm0011ae8cd564.cpe.net.cable.rogers.com> <42B70A6D.7030308@namesys.com> <200506201644.10429.ajwade@cpe00095b3131a0-cm0011ae8cd564.cpe.net.cable.rogers.com> <42B7F98B.5050405@namesys.com>
In-Reply-To: <42B7F98B.5050405@namesys.com>
X-Enigmail-Version: 0.90.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Edward Shishkin wrote:

>
> Hello,
> ZLIB_INFLATE/DEFLATE  will be selected by special reiser4 related
> configuration
> option "Enable reiser4 compression plugins of gzip family"
> (REISER4_ZLIB), but
> since this kind of support was discussed, it is in our working
> repository for a while..
>
> Anyway thanks,
> Edward.

I am sorry, are you telling him that it works for you because you have
code that is different?  Did I misunderstand you?  How is what is in
your working repository relevant to anybody but you?  Please supply a
full update patch.

Hans

