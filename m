Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262616AbUJ0SdG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262616AbUJ0SdG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Oct 2004 14:33:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262598AbUJ0S3g
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Oct 2004 14:29:36 -0400
Received: from delta.ece.northwestern.edu ([129.105.5.125]:20218 "EHLO
	delta.ece.northwestern.edu") by vger.kernel.org with ESMTP
	id S262592AbUJ0S2p (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Oct 2004 14:28:45 -0400
Message-ID: <417FE937.1040304@ece.northwestern.edu>
Date: Wed, 27 Oct 2004 13:30:15 -0500
From: Lei Yang <lya755@ece.northwestern.edu>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4.2) Gecko/20040921
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Lei Yang <lya755@ece.northwestern.edu>, linux-kernel@vger.kernel.org
Subject: Re: set blksize of block device
References: <417FE6A8.5090803@ece.northwestern.edu>
In-Reply-To: <417FE6A8.5090803@ece.northwestern.edu>
X-Enigmail-Version: 0.76.8.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Please cc me if you have answers to this, I am not on the list. Thanks a 
lot!

Lei Yang wrote:

> Hello,
>
> I am learning block device drivers and have a newbie question. Given a 
> block device, is there anyway that I could set its block size? For 
> example, I want to write a block device driver that will work on an 
> existing block device.  In this driver, I want block size smaller. 
> (The idea looks confusing but I could explain if anybody is interested 
> :- )  However,  typically the block size is 1KB, now I want to set it 
> to 512 or 256.  Can I do it?
>
> TIA
> Lei
>


