Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261563AbUAFIvk (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Jan 2004 03:51:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261567AbUAFIvk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Jan 2004 03:51:40 -0500
Received: from thebsh.namesys.com ([212.16.7.65]:14491 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP id S261563AbUAFIvh
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Jan 2004 03:51:37 -0500
Message-ID: <3FFA7717.7080808@namesys.com>
Date: Tue, 06 Jan 2004 11:51:35 +0300
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20031007
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jesper Juhl <juhl-lkml@dif.dk>
CC: "Tigran A. Aivazian" <tigran@veritas.com>,
       Hans Reiser <reiserfs-dev@namesys.com>,
       Daniel Pirkl <daniel.pirkl@email.cz>,
       Russell King <rmk@arm.linux.org.uk>, Will Dyson <will_dyson@pobox.com>,
       linux-kernel@vger.kernel.org, nikita@namesys.com
Subject: Re: Suspected bug infilesystems (UFS,ADFS,BEFS,BFS,ReiserFS) related
 to sector_t being unsigned, advice requested
References: <Pine.LNX.4.56.0401052343350.7407@jju_lnx.backbone.dif.dk>
In-Reply-To: <Pine.LNX.4.56.0401052343350.7407@jju_lnx.backbone.dif.dk>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jesper Juhl wrote:

>
>
>The problem is what seems (to me, but I could be dead wrong) to be invalid
>use of variables of type sector_t.
>
>  
>
thanks.  nikita, please clean.

-- 
Hans


