Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268069AbUHaLmN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268069AbUHaLmN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Aug 2004 07:42:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267882AbUHaLl4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Aug 2004 07:41:56 -0400
Received: from mx1.redhat.com ([66.187.233.31]:24281 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S267939AbUHaLlp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Aug 2004 07:41:45 -0400
Message-ID: <413463EA.8030805@redhat.com>
Date: Tue, 31 Aug 2004 07:41:30 -0400
From: Neil Horman <nhorman@redhat.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0; hi, Mom) Gecko/20020604 Netscape/7.01
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jeff Garzik <jgarzik@pobox.com>
CC: Linux Kernel <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       Jeremy Higdon <jeremy@sgi.com>
Subject: Re: [DOC] Linux kernel patch submission format
References: <413431F5.9000704@pobox.com>
In-Reply-To: <413431F5.9000704@pobox.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik wrote:
> 
> I tried to keep it as short as possible:  here is a page describing the 
> most optimal format for sending patches to Linux kernel developers.
> 
>     http://linux.yyz.us/patch-format.html
> 
> This URL should be permanent, feel free to bookmark it.
> Comments welcome.
> 
>     Jeff
> 
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

So, this may already be asked and answered (apologies if it has), but is 
it worth gpg-signing submissions so that authenticity can be verified to 
some degree when a patch is posted (and for archival purposes)? I ask 
because this is whats done on the fedora extras channel when updates get 
pushed, and it seems like a reasonable addition to the process.
Neil

-- 
/***************************************************
  *Neil Horman
  *Software Engineer
  *Red Hat, Inc.
  *nhorman@redhat.com
  *gpg keyid: 1024D / 0x92A74FA1
  *http://pgp.mit.edu
  ***************************************************/
