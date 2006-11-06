Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1753422AbWKFQrN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753422AbWKFQrN (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Nov 2006 11:47:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753435AbWKFQrN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Nov 2006 11:47:13 -0500
Received: from ug-out-1314.google.com ([66.249.92.172]:1937 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1753422AbWKFQrM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Nov 2006 11:47:12 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        b=CXdxKguSf6mziYzzJDQSvMpy286PcfjnHmj0AyzKZKKf80AYEQBeJkcRY5oEu+1b3Haccjoo6TpU1wEiCj8MWo88IilAXeCYvzxcXo7S5nWPUek3sv8Gb3UzgiFrjgrv3iBBjeF9zZqK0Sr5WK2zgzY30F0RAKz6VOt8q2uhBBc=
Message-ID: <84144f020611060847o6eb587ady383276a42163fa25@mail.gmail.com>
Date: Mon, 6 Nov 2006 18:47:10 +0200
From: "Pekka Enberg" <penberg@cs.helsinki.fi>
To: "Miguel Ojeda" <maxextreme@gmail.com>
Subject: Re: Re: [PATCH] mm/slab.c: whitespace cleanup
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
In-Reply-To: <653402b90611060827t7eaff5acl1a5cbc36c772ba29@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20061106164727.7ad2fb2c.maxextreme@gmail.com>
	 <84144f020611060818t5890143cn32865750073e602c@mail.gmail.com>
	 <653402b90611060827t7eaff5acl1a5cbc36c772ba29@mail.gmail.com>
X-Google-Sender-Auth: d7414402bcf89306
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/6/06, Miguel Ojeda <maxextreme@gmail.com> wrote:
> Isn't "p+i" more correct / easy to understand than "&p[i]"?

Perhaps but it is not a _whitespace_ cleanup.

                              Pekka
