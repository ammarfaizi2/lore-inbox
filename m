Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261165AbVDDIHk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261165AbVDDIHk (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Apr 2005 04:07:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261167AbVDDIHk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Apr 2005 04:07:40 -0400
Received: from funkmunch.net ([202.173.190.158]:61927 "EHLO mail.funkmunch.net")
	by vger.kernel.org with ESMTP id S261165AbVDDIHd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Apr 2005 04:07:33 -0400
Message-ID: <4250F5CB.4070605@funkmunch.net>
Date: Mon, 04 Apr 2005 18:07:39 +1000
From: Triffid Hunter <triffid_hunter@funkmunch.net>
User-Agent: Mozilla Thunderbird 1.0 (X11/20050321)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: =?ISO-8859-1?Q?Jose_=C1ngel_De_Bustos_P=E9rez?= 
	<jadebustos@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: A problem with kswapd
References: <59ab6ac105040400423fefd96a@mail.gmail.com>
In-Reply-To: <59ab6ac105040400423fefd96a@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

try 2.4.30 which has just been released (unchanged from 2.4.30-rc4)

Jose Ángel De Bustos Pérez wrote:
> Hi,
> 
> I have a problem with kswapd and I didn't find anything in the
> archives of the list (I hope not having missed someone).
> 
> kswapd is using 100% of CPU in a suse sles8 with kernel 2.4.241. This
> machine has its FS under LVM and ResiserFS, except for /boot which is
> in ext2.
> 
> Any idea? Thanks in advance.
