Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281719AbRKVUcl>; Thu, 22 Nov 2001 15:32:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281735AbRKVUcc>; Thu, 22 Nov 2001 15:32:32 -0500
Received: from chunnel.redhat.com ([199.183.24.220]:17903 "EHLO
	sisko.scot.redhat.com") by vger.kernel.org with ESMTP
	id <S281719AbRKVUcO>; Thu, 22 Nov 2001 15:32:14 -0500
Date: Thu, 22 Nov 2001 20:32:07 +0000
From: "Stephen C. Tweedie" <sct@redhat.com>
To: PVotruba@Chemoprojekt.cz
Cc: joelbeach@optushome.com.au, linux-kernel@vger.kernel.org,
        Stephen Tweedie <sct@redhat.com>
Subject: Re: Maximum (efficient) partition sizes for various filesystem ty pes...
Message-ID: <20011122203207.C11821@redhat.com>
In-Reply-To: <35E64A70B5ACD511BCB0000000004CA1095D08@NT_CHEMO>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <35E64A70B5ACD511BCB0000000004CA1095D08@NT_CHEMO>; from PVotruba@Chemoprojekt.cz on Mon, Nov 19, 2001 at 01:02:57PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, Nov 19, 2001 at 01:02:57PM +0100, PVotruba@Chemoprojekt.cz wrote:
> Hmm it looks like that Debians want's to avoid user impatience during
> excessive e2fsck job at startup. But technically, one can hardly expect
> problems - if there were any, they surely appeared already in this list :) 
> 
> Compared to *some* other OSes, linux makes fs checking after certain number
> of rw mounts. When thinks like that happen, some less enlightened users tend
> to be "derailed", because they don't expect that. :)

It's configurable: "man tune2fs".

Cheers,
 Stephen
