Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268079AbUHZJEH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268079AbUHZJEH (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Aug 2004 05:04:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268040AbUHZI6Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Aug 2004 04:58:24 -0400
Received: from rwcrmhc11.comcast.net ([204.127.198.35]:21648 "EHLO
	rwcrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S267882AbUHZItU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Aug 2004 04:49:20 -0400
Message-ID: <412DA40B.5040806@namesys.com>
Date: Thu, 26 Aug 2004 01:49:15 -0700
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040803
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jamie Lokier <jamie@shareable.org>
CC: viro@parcelfarce.linux.theplanet.co.uk, Linus Torvalds <torvalds@osdl.org>,
       Christoph Hellwig <hch@lst.de>, linux-fsdevel@vger.kernel.org,
       linux-kernel@vger.kernel.org,
       Alexander Lyamin aka FLX <flx@namesys.com>,
       ReiserFS List <reiserfs-list@namesys.com>
Subject: Re: silent semantic changes with reiser4
References: <20040824202521.GA26705@lst.de> <412CEE38.1080707@namesys.com> <20040825200859.GA16345@lst.de> <Pine.LNX.4.58.0408251314260.17766@ppc970.osdl.org> <20040825204240.GI21964@parcelfarce.linux.theplanet.co.uk> <Pine.LNX.4.58.0408251348240.17766@ppc970.osdl.org> <20040825212518.GK21964@parcelfarce.linux.theplanet.co.uk> <20040826001152.GB23423@mail.shareable.org> <20040826003055.GO21964@parcelfarce.linux.theplanet.co.uk> <20040826010049.GA24731@mail.shareable.org>
In-Reply-To: <20040826010049.GA24731@mail.shareable.org>
X-Enigmail-Version: 0.85.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jamie Lokier wrote:

>
>
>One of the big potential uses for file-as-directory is to go inside
>archive files, ELF files, .iso files and so on in a convenient way.
>  
>
Yes, this was part of the plan, tar file-directory plugins would be cute.


