Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268423AbUH3TAe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268423AbUH3TAe (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Aug 2004 15:00:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268758AbUH3S46
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Aug 2004 14:56:58 -0400
Received: from rwcrmhc12.comcast.net ([216.148.227.85]:63476 "EHLO
	rwcrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S268055AbUH3SzY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Aug 2004 14:55:24 -0400
Message-ID: <41337819.4070805@namesys.com>
Date: Mon, 30 Aug 2004 11:55:21 -0700
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040803
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Herbert Poetzl <herbert@13thfloor.at>
CC: Linus Torvalds <torvalds@osdl.org>, Christoph Hellwig <hch@lst.de>,
       flx@msu.ru, Christophe Saout <christophe@saout.de>,
       Andrew Morton <akpm@osdl.org>, linux-fsdevel@vger.kernel.org,
       linux-kernel@vger.kernel.org, flx@namesys.com,
       reiserfs-list@namesys.com
Subject: Re: reiser4 plugins
References: <20040826124929.GA542@lst.de> <1093525234.9004.55.camel@leto.cs.pocnet.net> <20040826130718.GB820@lst.de> <1093526273.11694.8.camel@leto.cs.pocnet.net> <20040826132439.GA1188@lst.de> <20040828105929.GB6746@alias> <Pine.LNX.4.58.0408281011280.2295@ppc970.osdl.org> <20040828190350.GA14152@alias> <20040828190901.GA18083@lst.de> <4130FBF8.8070005@namesys.com> <20040830160205.GA7718@MAIL.13thfloor.at>
In-Reply-To: <20040830160205.GA7718@MAIL.13thfloor.at>
X-Enigmail-Version: 0.85.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Herbert Poetzl wrote:

>
>hmm, so probably we have to wait until all
>tar packagers moved to reiser4, so that the
>available tar files are 'sorted properly' ...
>
>best,
>Herbert
>
>  
>
Or wait for a repacker, which will probably happen sooner. Distros that 
use reiser4 will probably tar in reiser4 order.
