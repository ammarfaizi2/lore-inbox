Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751287AbVLLVNw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751287AbVLLVNw (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Dec 2005 16:13:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751288AbVLLVNw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Dec 2005 16:13:52 -0500
Received: from warden-p.diginsite.com ([208.29.163.248]:32142 "HELO
	warden.diginsite.com") by vger.kernel.org with SMTP
	id S1751287AbVLLVNv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Dec 2005 16:13:51 -0500
Date: Mon, 12 Dec 2005 13:13:07 -0800 (PST)
From: David Lang <dlang@digitalinsight.com>
X-X-Sender: dlang@dlang.diginsite.com
To: Jesse Barnes <jesse.barnes@intel.com>
cc: "Randy.Dunlap" <rdunlap@xenotime.net>, Benjamin LaHaise <bcrl@kvack.org>,
       Dirk Steuwer <dirk@steuwer.de>, linux-kernel@vger.kernel.org
Subject: Re: Runs with Linux (tm)
In-Reply-To: <200512071022.35900.jesse.barnes@intel.com>
Message-ID: <Pine.LNX.4.62.0512121307500.267@qynat.qvtvafvgr.pbz>
References: <1133779953.9356.9.camel@laptopd505.fenrus.org>
 <20051207141720.GA533@kvack.org> <Pine.LNX.4.58.0512071008450.17648@shark.he.net>
 <200512071022.35900.jesse.barnes@intel.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 7 Dec 2005, Jesse Barnes wrote:

> Now, who's in a position to make this happen?  Maybe Linux International?
> (I think Maddog mentioned something like this at a Kernel Summit a few
> years ago.)

I don't remember tha name of the orginization, but the group that Linus 
setup to enforce the trademark would be perfect for this. licensing a 
'runs with linux' sticker would be exactly the type of thing the trademark 
is designed to protect.

I think it's obvious that anything with in-kernel drivers would qualify 
(new versions of hardware may need driver updates before they could use 
the sticker) and if Linus could define a suitable level of documentation 
of the hardware I think that that should very quickly lead to an in-kernel 
driver (and given hardware lead time it may be reasonable to allow the 
sticker based on the release of documentation)

I would not like to see it for external drivers, especially ones that work 
only with specific kernels from specific distros. even if the source is 
available, unless it can be merged into the kernel it's going to be a 
ongoing problem (although the open-source-but-external driver code could 
end up being deemed 'sufficiant documentation')

David Lang

-- 
There are two ways of constructing a software design. One way is to make it so simple that there are obviously no deficiencies. And the other way is to make it so complicated that there are no obvious deficiencies.
  -- C.A.R. Hoare

