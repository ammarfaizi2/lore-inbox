Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292851AbSCISiM>; Sat, 9 Mar 2002 13:38:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292856AbSCISiC>; Sat, 9 Mar 2002 13:38:02 -0500
Received: from port5.ds1-sby.adsl.cybercity.dk ([212.242.169.198]:19041 "EHLO
	trider-g7.fabbione.net") by vger.kernel.org with ESMTP
	id <S292851AbSCISh5>; Sat, 9 Mar 2002 13:37:57 -0500
Message-ID: <3C8A5681.2050000@fabbione.net>
Date: Sat, 09 Mar 2002 19:37:53 +0100
From: Fabio Massimo Di Nitto <fabbione@fabbione.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.8) Gecko/20020307
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: 23 second kernel compile (aka which patches help scalibility on NUMA)
In-Reply-To: <20020309164305.GA2914@codepoet.org> <126403558.1015667602@[10.10.2.3]>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri Mar 08, 2002 at 09:47:04PM -0800, Martin J. Bligh wrote:

 >"time make -j32 bzImage" is now down to 23 seconds.
 >(16 way NUMA-Q, 700MHz P3's, 4Gb RAM).

hmmm strange... last time I compile a kernel on my m68k after 23 seconds 
was still
trying to perform an CR after I pressed enter :))) are you sure you are 
not running too fast??? ;)

