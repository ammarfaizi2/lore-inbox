Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264971AbUASPTW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Jan 2004 10:19:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265139AbUASPTW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Jan 2004 10:19:22 -0500
Received: from nibbel.kulnet.kuleuven.ac.be ([134.58.240.41]:10149 "EHLO
	nibbel.kulnet.kuleuven.ac.be") by vger.kernel.org with ESMTP
	id S264971AbUASPTU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Jan 2004 10:19:20 -0500
Message-ID: <400BF587.3050306@mech.kuleuven.ac.be>
Date: Mon, 19 Jan 2004 16:19:35 +0100
From: Panagiotis Issaris <panagiotis.issaris@mech.kuleuven.ac.be>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6b) Gecko/20031221 Thunderbird/0.4
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Mike Fedyk <mfedyk@matchmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.1-mm4 nfsd broken
References: <400BEFD3.60506@mech.kuleuven.ac.be> <20040119150922.GJ1748@srv-lnx2600.matchmail.com>
In-Reply-To: <20040119150922.GJ1748@srv-lnx2600.matchmail.com>
X-Enigmail-Version: 0.82.5.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mike,

Mike Fedyk wrote:

>On Mon, Jan 19, 2004 at 03:55:15PM +0100, Panagiotis Issaris wrote:
>  
>
>>Loading nfsd.ko results in the following message:
>>nfsd: Unknown symbol dnotify_parent
>>    
>>
>
>There was a patch for this posted as a reply to 2.6.1-mm4 that exports
>dnotify_parent to modules.  You should get that.
>  
>
Thanks!

>Did you have any troubles with stale filehandles in 2.6.1?
>  
>
No, I haven't noticed any troubles with NFS...
but I'm using NFS to serve just one cliet, a target board for embedded 
development, and I rarely access the same files from multiple hosts.


With friendly regards,
Takis
