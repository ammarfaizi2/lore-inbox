Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030542AbWJ3PrU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030542AbWJ3PrU (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Oct 2006 10:47:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030545AbWJ3PrU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Oct 2006 10:47:20 -0500
Received: from ug-out-1314.google.com ([66.249.92.175]:50860 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1030542AbWJ3PrU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Oct 2006 10:47:20 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        b=oC8MbWNY235r2PWndAod70F79OOQoqTw1pGzrK06iXORODNl3GRDaMrSovuB3JxOT35/8aLHsVW9aQCL8TamFiaz3ixPOiLzD5fnWm0f7u+95FM/CA2mcqoY4P9/+dPQpFR06BnewK5jMgPbxBQe21xZwScTbhUHUjUQ4ISF3vs=
Message-ID: <84144f020610300747q2652e185u6499510659a54a8c@mail.gmail.com>
Date: Mon, 30 Oct 2006 17:47:18 +0200
From: "Pekka Enberg" <penberg@cs.helsinki.fi>
To: "Andy Whitcroft" <apw@shadowen.org>
Subject: Re: Re: Slab panic on 2.6.19-rc3-git5 (-git4 was OK)
Cc: "Linus Torvalds" <torvalds@osdl.org>,
       "Martin J. Bligh" <mbligh@mbligh.org>, "Andrew Morton" <akpm@osdl.org>,
       "Martin J. Bligh" <mbligh@google.com>,
       "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
       linux-mm <linux-mm@kvack.org>
In-Reply-To: <45461BC7.5050609@shadowen.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <454442DC.9050703@google.com>
	 <20061029000513.de5af713.akpm@osdl.org>
	 <4544E92C.8000103@shadowen.org> <4545325D.8080905@mbligh.org>
	 <Pine.LNX.4.64.0610291718481.25218@g5.osdl.org>
	 <45461BC7.5050609@shadowen.org>
X-Google-Sender-Auth: 6d0ae703210507b1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/30/06, Andy Whitcroft <apw@shadowen.org> wrote:
> Test results are back on the version of the slab panic fix which Linus'
> has committed in his tree.  This change on top of 2.6.19-rc3-git5 is
> good.  2.6.19-rc3-git6 is also showing good on this machine.

FWIW, the patch looks correct to me also.

                           Pekka
