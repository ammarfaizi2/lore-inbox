Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262687AbTK1QuZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Nov 2003 11:50:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262709AbTK1QuZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Nov 2003 11:50:25 -0500
Received: from mail-atl.bigfish.com ([63.161.60.61]:30180 "EHLO
	mail3-atl-R.bigfish.com") by vger.kernel.org with ESMTP
	id S262687AbTK1QuX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Nov 2003 11:50:23 -0500
Message-ID: <3FC77CC3.7090702@lehman.com>
Date: Fri, 28 Nov 2003 11:50:11 -0500
From: "Shantanu Goel" <Shantanu.Goel@lehman.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4.1)
 Gecko/20031114
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Trond Myklebust" <trond.myklebust@fys.uio.no>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [Fwd: [NFS PATCH] 2.6.0-test10 Invalidate cached inode
 attributes after rename]
References: <3FC763A5.6030404@lehman.com>
 <shsu14oh27m.fsf@charged.uio.no>
In-Reply-To: <shsu14oh27m.fsf@charged.uio.no>
X-WSS-ID: 13D9A34F755367-01-01
Content-Type: text/plain;
 charset=us-ascii;
 format=flowed
Content-Transfer-Encoding: 7bit
X-BigFish: v
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

BTW, this also affects 2.4 kernels (e.g. RedHat's AS3 kernel) which 
include your CTO patches that aren't in the upstream kernels yet.

Thanks,
Shantanu

Trond Myklebust wrote:

>>>>>>" " == Shantanu Goel <Shantanu.Goel@lehman.com> writes:
>>>>>>            
>>>>>>
>
>     > I initially mailed this to the NFS mailing list on
>     > sourceforge.net but it doesn't seem to have made it through.
>
>
>It's not a critical bugfix. It will make it in, but not while the
>current code-freeze is in place.
>
>Cheers,
>  Trond
>
>  
>



------------------------------------------------------------------------------
This message is intended only for the personal and confidential use of the
designated recipient(s) named above.  If you are not the intended recipient of
this message you are hereby notified that any review, dissemination,
distribution or copying of this message is strictly prohibited.  This
communication is for information purposes only and should not be regarded as
an offer to sell or as a solicitation of an offer to buy any financial
product, an official confirmation of any transaction, or as an official
statement of Lehman Brothers.  Email transmission cannot be guaranteed to be
secure or error-free.  Therefore, we do not represent that this information is
complete or accurate and it should not be relied upon as such.  All
information is subject to change without notice.

