Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264051AbTEOOnt (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 May 2003 10:43:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264056AbTEOOnt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 May 2003 10:43:49 -0400
Received: from web40506.mail.yahoo.com ([66.218.78.123]:41740 "HELO
	web40506.mail.yahoo.com") by vger.kernel.org with SMTP
	id S264051AbTEOOns (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 May 2003 10:43:48 -0400
Message-ID: <20030515145633.37071.qmail@web40506.mail.yahoo.com>
Date: Thu, 15 May 2003 07:56:33 -0700 (PDT)
From: Alex Davis <alex14641@yahoo.com>
Subject: Re: link error building kernel with gcc-3.3
To: "David S. Miller" <davem@redhat.com>, jmorris@intercode.com.au
Cc: alex14641@yahoo.com, linux-kernel@vger.kernel.org, netdev@oss.sgi.com
In-Reply-To: <20030514.224214.42791773.davem@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Can you push it to 2.4.x as well?

-Alex

--- "David S. Miller" <davem@redhat.com> wrote:
>    From: James Morris <jmorris@intercode.com.au>
>    Date: Thu, 15 May 2003 15:38:15 +1000 (EST)
>    
>    I wonder, does this mean that the compiler failed to inline the function?
>    
>    Removing __inline__ is not the correct solution.
>    
> I already posted what the correct fix is :-)  And this is already
> pushed to 2.5.x

__________________________________
Do you Yahoo!?
The New Yahoo! Search - Faster. Easier. Bingo.
http://search.yahoo.com
