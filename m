Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261907AbVFVCz1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261907AbVFVCz1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Jun 2005 22:55:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262525AbVFVCz1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Jun 2005 22:55:27 -0400
Received: from rwcrmhc13.comcast.net ([204.127.198.39]:13190 "EHLO
	rwcrmhc13.comcast.net") by vger.kernel.org with ESMTP
	id S261907AbVFVCzW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Jun 2005 22:55:22 -0400
Message-ID: <42B8D314.3090900@namesys.com>
Date: Tue, 21 Jun 2005 19:55:16 -0700
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.5) Gecko/20041217
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andi Kleen <ak@suse.de>
CC: Alexander Lyamin aka FLX <flx@namesys.com>,
       Alexander Zarochentcev <zam@namesys.com>, vs <vs@thebsh.namesys.com>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       ReiserFS List <reiserfs-list@namesys.com>
Subject: Re: -mm -> 2.6.13 merge status
References: <20050620235458.5b437274.akpm@osdl.org.suse.lists.linux.kernel> <p73d5qgc67h.fsf@verdi.suse.de> <42B86027.3090001@namesys.com> <20050621195642.GD14251@wotan.suse.de> <42B8C0FF.2010800@namesys.com> <20050622015724.GN14251@wotan.suse.de>
In-Reply-To: <20050622015724.GN14251@wotan.suse.de>
X-Enigmail-Version: 0.90.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen wrote:

>
> Just there are doubts that your
>code follows the Linux coding standards enough to not be a undue
>mainteance burden in mainline. 
>
We get only a few bugfixes from outsiders, and the rest are done by us. 
The customers who buy licenses in addition to the GPL from us for
hundreds of thousands of dollars tend to make remarks to the effect of
"we licensed your code for more money in part because it was way easier
to work on than XXX linux filesystem".

I like feedback on our code, and I particularly like feedback from a Mr.
Andi Kleen, but there is no need to tie it to merging.  If, however, it
serves as an effective excuse to get some of your time allocated by SuSE
management, sure, go for it.;-)

Hans
