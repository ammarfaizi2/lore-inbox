Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129618AbRCAOlm>; Thu, 1 Mar 2001 09:41:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129614AbRCAOld>; Thu, 1 Mar 2001 09:41:33 -0500
Received: from [64.64.109.142] ([64.64.109.142]:23303 "EHLO
	quark.didntduck.org") by vger.kernel.org with ESMTP
	id <S129612AbRCAOlR>; Thu, 1 Mar 2001 09:41:17 -0500
Message-ID: <3A9E5F41.E5F9B947@didntduck.org>
Date: Thu, 01 Mar 2001 09:40:01 -0500
From: Brian Gerst <bgerst@didntduck.org>
X-Mailer: Mozilla 4.73 [en] (WinNT; U)
X-Accept-Language: en
MIME-Version: 1.0
To: aprasad@in.ibm.com
CC: linux-kernel@vger.kernel.org
Subject: Re: Assembler Error:"Unsupported Relocation type "while compile mycode 
 with kernel
In-Reply-To: <CA256A02.004F08C7.00@d73mta05.au.ibm.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

aprasad@in.ibm.com wrote:
> 
> Hi,
> sorry for this post, but this message i got when  tried to compile my code
> in the kernel..
> I am unable to figure out the problem.
> 
> I have put the my code in drivers/misc directory and made the appropriate
> entry in Makefile.

We need information than just "it doesn't work", like binutils
version/architecture, exact error message, code fragments, etc.

--

				Brian Gerst
