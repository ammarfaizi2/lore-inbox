Return-Path: <linux-kernel-owner+w=401wt.eu-S964931AbWL1FrX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964931AbWL1FrX (ORCPT <rfc822;w@1wt.eu>);
	Thu, 28 Dec 2006 00:47:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964932AbWL1FrX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Dec 2006 00:47:23 -0500
Received: from nz-out-0506.google.com ([64.233.162.231]:4066 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964931AbWL1FrW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Dec 2006 00:47:22 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=h6BziLpIrTB1r/BCJjPH7RAjEzCW/8thWEeyAqtfzfgHd3bm5nYglIBxJmSHSqBlW0r67AJfiAGjkNd1ENvhKi3JDUU+7nnTbgYzkPjyASCnpgcsam+cdKBGwet2EelrDofOOeFD04758DxBmb+6tvfVaZ88yXpdkQF9XmmyfKs=
Message-ID: <97a0a9ac0612272147o7d0a5527ncfbd15e230d99a6e@mail.gmail.com>
Date: Wed, 27 Dec 2006 22:47:22 -0700
From: "Gordon Farquharson" <gordonfarquharson@gmail.com>
To: "David Miller" <davem@davemloft.net>
Subject: Re: [PATCH] mm: fix page_mkclean_one
Cc: torvalds@osdl.org, ranma@tdiedrich.de, tbm@cyrius.com,
       a.p.zijlstra@chello.nl, andrei.popa@i-neo.ro, akpm@osdl.org,
       hugh@veritas.com, nickpiggin@yahoo.com.au, arjan@infradead.org,
       linux-kernel@vger.kernel.org
In-Reply-To: <20061227.214149.74746689.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <97a0a9ac0612272032uf5358c4qf12bf183f97309a6@mail.gmail.com>
	 <Pine.LNX.4.64.0612272039411.4473@woody.osdl.org>
	 <97a0a9ac0612272120g144d2364n932d6f66728f162e@mail.gmail.com>
	 <20061227.214149.74746689.davem@davemloft.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi David

On 12/27/06, David Miller <davem@davemloft.net> wrote:

> Me too, I added "-D_POSIX_C_SOURCE=200112" to "fix" this.

That works for me. Thanks for the tip.

Gordon

-- 
Gordon Farquharson
