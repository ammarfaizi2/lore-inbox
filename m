Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266970AbSKLWHG>; Tue, 12 Nov 2002 17:07:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266971AbSKLWHG>; Tue, 12 Nov 2002 17:07:06 -0500
Received: from mail-04.iinet.net.au ([203.59.3.36]:12810 "HELO
	mail.iinet.net.au") by vger.kernel.org with SMTP id <S266970AbSKLWHF>;
	Tue, 12 Nov 2002 17:07:05 -0500
Message-ID: <3DD0D42E.8040706@iinet.net.au>
Date: Tue, 12 Nov 2002 21:13:02 +1100
From: Nero <neroz@iinet.net.au>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.2b) Gecko/20021016
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: john slee <indigoid@higherplane.net>
CC: linux-kernel@vger.kernel.org
Subject: Re: [CHECKER] 18 potential security holes
References: <5.1.0.14.2.20021111143426.045c4d90@rdg12.pobox.stanford.edu> <20021112072607.GC17478@higherplane.net>
In-Reply-To: <5.1.0.14.2.20021111143426.045c4d90@rdg12.pobox.stanford.edu>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

john slee wrote:

> On Mon, Nov 11, 2002 at 02:35:06PM -0800, Russell Greene wrote:
>
> >You can look at this checker as essentially tracking whether the
> >information from an untrusted source (e.g., from copy_from_user) can 
> reach
> >a trusting sink (e.g., an array index).
>
>
> great to see stanford running this again!  it has been extremely helpful
> in the past
>
> thanks!
>
> j.


Why isn't the code for this available?


