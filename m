Return-Path: <linux-kernel-owner+w=401wt.eu-S1751609AbXAUVAw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751609AbXAUVAw (ORCPT <rfc822;w@1wt.eu>);
	Sun, 21 Jan 2007 16:00:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751614AbXAUVAw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Jan 2007 16:00:52 -0500
Received: from terminus.zytor.com ([192.83.249.54]:38583 "EHLO
	terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751591AbXAUVAv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Jan 2007 16:00:51 -0500
Message-ID: <45B3D3E9.8090900@zytor.com>
Date: Sun, 21 Jan 2007 12:58:17 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Thunderbird 1.5.0.9 (X11/20061219)
MIME-Version: 1.0
To: Ralf Baechle <ralf@linux-mips.org>
CC: =?UTF-8?B?IlMuw4dhxJ9sYXIgT251ciI=?= <caglar@pardus.org.tr>,
       Adrian Bunk <bunk@stusta.de>, linux-kernel@vger.kernel.org
Subject: Re: Linux 2.6.16.38
References: <20070121160900.GI9093@stusta.de> <200701211837.28987.caglar@pardus.org.tr> <20070121190215.GA12452@linux-mips.org>
In-Reply-To: <20070121190215.GA12452@linux-mips.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ralf Baechle wrote:
> On Sun, Jan 21, 2007 at 06:37:24PM +0200, S.Çağlar Onur wrote:
> 
>> 21 Oca 2007 Paz tarihinde şunları yazmıştınız:
>>> RSS feed of the git tree:
>>> http://www.kernel.org/git/?p=linux/kernel/git/stable/linux-2.6.16.y.git;a=r
>> I already mailed to webmaster _at_ kernel.org 2 days ago but still all RSS 
>> feeds gaves "Internal Server Error"
> 
> kernel.org is not in quite the best shape currently due to the machines'
> massive overload, so this may take a little while to get fixed.
> 

Do note that www2.kernel.org has a load that is usually 1/20th of 
www1.kernel.org; apparently due to Microsoft DNS braindamage (which 
affects anyone whose ISP uses MS-DNS.)  Using www2.kernel.org explicitly 
is likely to give you better performance.  HOWEVER, performance is going 
to suck due to the measures we've had to take on the servers regardless, 
and it's entirely likely git-rss is totally broken.  Again, we should 
have a dedicated git server in operation in about a month.

	-hpa
