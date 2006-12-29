Return-Path: <linux-kernel-owner+w=401wt.eu-S965220AbWL2WMb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965220AbWL2WMb (ORCPT <rfc822;w@1wt.eu>);
	Fri, 29 Dec 2006 17:12:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030185AbWL2WMa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Dec 2006 17:12:30 -0500
Received: from 1wt.eu ([62.212.114.60]:1679 "EHLO 1wt.eu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965220AbWL2WMa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Dec 2006 17:12:30 -0500
Date: Fri, 29 Dec 2006 23:09:16 +0100
From: Willy Tarreau <w@1wt.eu>
To: "Dr.-Ing. Ingo D. Rullhusen" <d01c@uni-bremen.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: PROBLEM: setup apm as module version 2.4.34
Message-ID: <20061229220916.GN24090@1wt.eu>
References: <45955E67.7060408@uni-bremen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <45955E67.7060408@uni-bremen.de>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, Dec 29, 2006 at 07:28:55PM +0100, Dr.-Ing. Ingo D. Rullhusen wrote:
> Hello,
> 
> i hope that's the right address for this little problem, which arises 
> with linux kernel 2.4.34.

Yes, it's the right address.

> If i compile the Advanced Power Management as module it do not work. If 
> i try a depmod i get an unresolved symbols message and so it cannot be 
> loaded of course.
> 
> But if the APM part is compiled into the kernel directly it works.
> 
> Simply disable the compile as module option?

I'm sorry, but could you be a bit more precise : config, error messages ?
Also, is this problem a regression (ie: did it work on a known previous
version, and if so, which one) ?

> Thanks
>   Ingo

Regards,
Willy

