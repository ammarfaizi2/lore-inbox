Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262961AbTEGGln (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 May 2003 02:41:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262963AbTEGGln
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 May 2003 02:41:43 -0400
Received: from pc1-cmbg4-4-cust110.cmbg.cable.ntl.com ([81.96.70.110]:54276
	"EHLO thekelleys.org.uk") by vger.kernel.org with ESMTP
	id S262961AbTEGGlm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 May 2003 02:41:42 -0400
Message-ID: <3EB8AD41.5010605@thekelleys.org.uk>
Date: Wed, 07 May 2003 07:52:49 +0100
From: Simon Kelley <srk@thekelleys.org.uk>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3) Gecko/20030327 Debian/1.3-4
X-Accept-Language: en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: Simon Kelley <simon@thekelleys.org.uk>,
       "J. Bruce Fields" <bfields@fieldses.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       torvalds@transmeta.com
Subject: Re: Binary firmware in the kernel - licensing issues.
References: <3EB79ECE.4010709@thekelleys.org.uk>	 <20030506121954.GO24892@mea-ext.zmailer.org>	 <20030506151644.GA19898@fieldses.org>  <3EB7D7D9.2050603@thekelleys.org.uk> <1052234481.1202.20.camel@dhcp22.swansea.linux.org.uk>
In-Reply-To: <1052234481.1202.20.camel@dhcp22.swansea.linux.org.uk>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> On Maw, 2003-05-06 at 16:42, Simon Kelley wrote:
> 
>>Then, as you say, I need to know if the kernel developers have given
>>permission to distribute a work which combines Atmel's blob with
>>their source.[1]
> 
> 
> Either the GPL does or it doesn't.
<snip>
> Na.. firmware stuff needs sorting out, but from the conversations I've
> seem so far that involved people with a knowledge of law thats by
> putting the firmware out of the kernel entirely
> 

Either the GPL allows this or it doesn't or maybe it is just not clear.
If it is in fact silent or ambiguous on the issue then Linus is a much 
more useful resource than Lawyers. If he pronounces firmware blobs OK
and doesn't get sued by a significant number of the other copyright
holders then the decision is set. Similary it's unlikely that anyone
else would risk it if Linus says it is not OK.

Same procedure as that which caused Linus's "Binary-only modules can
link to the kernel without voilating the GPL" pronouncement.

Linus?

Cheers,

Simon

