Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261282AbTC0Sq3>; Thu, 27 Mar 2003 13:46:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261290AbTC0Sq3>; Thu, 27 Mar 2003 13:46:29 -0500
Received: from a089148.adsl.hansenet.de ([213.191.89.148]:59271 "EHLO
	ds666.starfleet") by vger.kernel.org with ESMTP id <S261282AbTC0Sq2>;
	Thu, 27 Mar 2003 13:46:28 -0500
Message-ID: <3E8349B6.7010603@portrix.net>
Date: Thu, 27 Mar 2003 19:57:58 +0100
From: Jan Dittmer <j.dittmer@portrix.net>
Organization: portrix.net GmbH
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4a) Gecko/20030305
X-Accept-Language: en
MIME-Version: 1.0
To: Greg KH <greg@kroah.com>
CC: KML <linux-kernel@vger.kernel.org>
Subject: Re: lm sensors sysfs file structure
References: <1048582394.4774.7.camel@workshop.saharact.lan> <20030325175603.GG15823@kroah.com> <1048705473.7569.10.camel@nosferatu.lan> <3E82024A.4000809@portrix.net> <20030326202622.GJ24689@kroah.com> <3E82292E.536D9196@paradyne.com> <20030326225234.GA27436@kroah.com> <3E83459A.3090803@portrix.net> <20030327185222.GI32667@kroah.com>
In-Reply-To: <20030327185222.GI32667@kroah.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[ stripped some cc's ]

Greg KH wrote:
> On Thu, Mar 27, 2003 at 07:40:26PM +0100, Jan Dittmer wrote:
> 
>>Btw, is it indended behaviour of sysfs, that after writing to a file, 
>>the size is zero?
> 
> 
> Hm, don't know about that, I haven't seen that before.  If you cat the
> file after writing it, does the file size change?
> 
No it stays 0. Happens also with other files in sysfs.

Jan

