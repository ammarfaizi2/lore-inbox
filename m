Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263435AbUAOWA2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Jan 2004 17:00:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263486AbUAOWA1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Jan 2004 17:00:27 -0500
Received: from mail47-s.fg.online.no ([148.122.161.47]:64444 "EHLO
	mail47.fg.online.no") by vger.kernel.org with ESMTP id S263435AbUAOWAU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Jan 2004 17:00:20 -0500
Message-ID: <40070D64.6090307@online.no>
Date: Thu, 15 Jan 2004 23:00:04 +0100
From: Andreas Tolfsen <ato@online.no>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.5b) Gecko/20030827
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Roman Zippel <zippel@linux-m68k.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: True story: "gconfig" removed root folder...
References: <1074177405.3131.10.camel@oebilgen> <Pine.LNX.4.58.0401151558590.27223@serv> <20040115212304.GA25296@rlievin.dyndns.org> <Pine.LNX.4.58.0401152245030.27223@serv>
In-Reply-To: <Pine.LNX.4.58.0401152245030.27223@serv>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Roman Zippel wrote:

> Hi,
> 
> On Thu, 15 Jan 2004, Romain Lievin wrote:
> 
>>I have managed to reproduce bug: make gconfig, go to the '/' directory,
>>type 'root' as file and ... you get a 'root' file. The 'root' directory is
>>destroyed !
> 
> 
> What do you mean with "destroyed"? All I can reproduce here is that it's
> simply moved away, but it's still there!

Is it supposed to be moved away?  I'm just being curious...



