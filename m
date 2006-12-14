Return-Path: <linux-kernel-owner+w=401wt.eu-S1751959AbWLNXdK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751959AbWLNXdK (ORCPT <rfc822;w@1wt.eu>);
	Thu, 14 Dec 2006 18:33:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751976AbWLNXdK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Dec 2006 18:33:10 -0500
Received: from ug-out-1314.google.com ([66.249.92.168]:10465 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751974AbWLNXdI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Dec 2006 18:33:08 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=pR3pbJuo02a9GKJNs1VbZ2kYntvzuJINg8Irj0zF66e3bIEHFLuP9xPaVcsgqKrS2EIk9A7bJGjMJ6IUzpuHdUnS/sJ7h2C7B0jExYXzYDJc7WFf3FYtl6Qf+CxvOsx7SLNL/bXT+5HfpPl45ycXwfu1/4pfsw7E6s0UIXo/psE=
Message-ID: <7b69d1470612141533v6ea076ap7149dbabceeb8ab4@mail.gmail.com>
Date: Thu, 14 Dec 2006 17:33:06 -0600
From: "Scott Preece" <sepreece@gmail.com>
To: "Randy Dunlap" <randy.dunlap@oracle.com>
Subject: Re: [PATCH/RFC] CodingStyle updates
Cc: lkml <linux-kernel@vger.kernel.org>, akpm <akpm@osdl.org>,
       jesper.juhl@gmail.com
In-Reply-To: <20061207004838.4d84842c.randy.dunlap@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20061207004838.4d84842c.randy.dunlap@oracle.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>  Outside of comments, documentation and except in Kconfig, spaces are never
>  used for indentation, and the above example is deliberately broken.
---

I realize it isn't text you added, but what's that supposed to mean?
Surely the 8-character indents are made up of spaces.  Does it mean
"spaces other than 8-space blocks"? In any case, how does it synch
with the following chapter's statement that continuations " are placed
substantially to the right" - isn't that done with spaces, too?

Or am I just totally spacing out on what was meant?

scott
