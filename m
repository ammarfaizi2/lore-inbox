Return-Path: <linux-kernel-owner+w=401wt.eu-S1751602AbXAUUvN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751602AbXAUUvN (ORCPT <rfc822;w@1wt.eu>);
	Sun, 21 Jan 2007 15:51:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751609AbXAUUvN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Jan 2007 15:51:13 -0500
Received: from terminus.zytor.com ([192.83.249.54]:53903 "EHLO
	terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751600AbXAUUvM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Jan 2007 15:51:12 -0500
Message-ID: <45B3D1A3.3010309@zytor.com>
Date: Sun, 21 Jan 2007 12:48:35 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Thunderbird 1.5.0.9 (X11/20061219)
MIME-Version: 1.0
To: caglar@pardus.org.tr
CC: Adrian Bunk <bunk@stusta.de>, linux-kernel@vger.kernel.org
Subject: Re: Linux 2.6.16.38
References: <20070121160900.GI9093@stusta.de> <200701211837.28987.caglar@pardus.org.tr>
In-Reply-To: <200701211837.28987.caglar@pardus.org.tr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

S.Çağlar Onur wrote:
> 21 Oca 2007 Paz tarihinde şunları yazmıştınız:
>> RSS feed of the git tree:
>> http://www.kernel.org/git/?p=linux/kernel/git/stable/linux-2.6.16.y.git;a=r
> 
> I already mailed to webmaster _at_ kernel.org 2 days ago but still all RSS 
> feeds gaves "Internal Server Error"
> 

We're aware of the problem, and it's almost certainly related either to 
the high loads we've had recently or to the necessary load-mitigation 
issues.  Realistically, it probably won't be fixed until we have a 
dedicated git server in place, which is in process; it will probably be 
installed some time in February.

	-hpa
