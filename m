Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261982AbUKCXzz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261982AbUKCXzz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Nov 2004 18:55:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261979AbUKCXxs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Nov 2004 18:53:48 -0500
Received: from c7ns3.center7.com ([216.250.142.14]:61855 "EHLO
	smtp.slc03.viawest.net") by vger.kernel.org with ESMTP
	id S261985AbUKCXuA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Nov 2004 18:50:00 -0500
Message-ID: <418973F3.9050007@drdos.com>
Date: Wed, 03 Nov 2004 17:12:35 -0700
From: "Jeff V. Merkey" <jmerkey@drdos.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040510
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Trond Myklebust <trond.myklebust@fys.uio.no>
Cc: Jeff Garzik <jgarzik@pobox.com>, Brad Campbell <brad@wasp.net.au>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: nfs stale filehandle issues with 2.6.10-rc1 in-kernel server
References: <41877751.502@wasp.net.au>	 <1099413424.7582.5.camel@lade.trondhjem.org> <4187E4E1.5080304@pobox.com>	 <4187F69E.9020604@drdos.com> <1099431477.7854.21.camel@lade.trondhjem.org>	 <20041102225304.GA11441@galt.devicelogics.com> <41882414.2070003@drdos.com>	 <1099444402.9957.8.camel@lade.trondhjem.org> <41890D5F.4000006@drdos.com>	  <41894FC0.6080609@drdos.com> <1099524768.16898.18.camel@lade.trondhjem.org>
In-Reply-To: <1099524768.16898.18.camel@lade.trondhjem.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Trond Myklebust wrote:

>on den 03.11.2004 Klokka 14:38 (-0700) skreiv Jeff V. Merkey:
>  
>
>>I personally think this is a broken behavior, but perhaps it's in line 
>>with some NFS
>>spec somewhere.  I have coded around it, but thout I would mention it to
>>you.
>>    
>>
>
>This should already be fixed in 2.6.x kernels.
>
>Cheers,
>  Trond
>
>  
>
I'll test it and let you know.  I saw this on a 2.4.18 kernel in a 2.6.X 
NFS network test setup.  I have not verified
it on 2.6.X.  Thanks for the heads up, sounds like you fixed it.

Jeff

