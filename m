Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289148AbSA1IRU>; Mon, 28 Jan 2002 03:17:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289162AbSA1IRK>; Mon, 28 Jan 2002 03:17:10 -0500
Received: from mail.nmskb.cz ([213.151.92.16]:10715 "EHLO sam.nmskb.cz")
	by vger.kernel.org with ESMTP id <S289148AbSA1IRG>;
	Mon, 28 Jan 2002 03:17:06 -0500
Message-ID: <3C550917.5000500@nmskb.cz>
Date: Mon, 28 Jan 2002 09:17:27 +0100
From: Marian Jancar <jancar@nmskb.cz>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.7) Gecko/20011226
X-Accept-Language: cs, en-us
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: touch commands in Makefiles
In-Reply-To: <20898.1012041538@ocs3.intra.ocs.com.au>
Content-Type: text/plain; charset=ISO-8859-2; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 28 Jan 2002 08:23:34.0865 (UTC) FILETIME=[14024410:01C1A7D5]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Keith Owens wrote:

>Even easier with kbuild 2.5, it has shadow trees.  You keep the base
>read only, copy the files to modify to a separate tree and kbuild 2.5
>logically merges all the files.
>

Does it allow to compile more kernels each with its own config from one 
source tree?

Marian Jancar


