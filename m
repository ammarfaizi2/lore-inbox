Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1163414AbWLGVgp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1163414AbWLGVgp (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Dec 2006 16:36:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1163418AbWLGVgp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Dec 2006 16:36:45 -0500
Received: from rgminet01.oracle.com ([148.87.113.118]:16397 "EHLO
	rgminet01.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1163414AbWLGVgo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Dec 2006 16:36:44 -0500
Message-ID: <45788975.1000401@oracle.com>
Date: Thu, 07 Dec 2006 13:36:53 -0800
From: Randy Dunlap <randy.dunlap@oracle.com>
User-Agent: Thunderbird 1.5.0.5 (X11/20060719)
MIME-Version: 1.0
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
CC: Chris Friesen <cfriesen@nortel.com>, lkml <linux-kernel@vger.kernel.org>,
       akpm <akpm@osdl.org>, jesper.juhl@gmail.com
Subject: Re: [PATCH/RFC] CodingStyle updates
References: <20061207004838.4d84842c.randy.dunlap@oracle.com> <Pine.LNX.4.61.0612071206160.2863@yvahk01.tjqt.qr> <45783AE5.9090706@nortel.com> <Pine.LNX.4.61.0612071927140.31022@yvahk01.tjqt.qr>
In-Reply-To: <Pine.LNX.4.61.0612071927140.31022@yvahk01.tjqt.qr>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Whitelist: TRUE
X-Whitelist: TRUE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jan Engelhardt wrote:
>>> What keyword is "defined"? Did you have too much Perl coffee? :)
>> Maybe macro formatting?
>>
>> #if defined(CONFIG_FOO)

Yes, that's it.

> Ah thanks for the hint. This also raises another stylistic aspect:
> 
> #ifdef XYZ over #if defined(XYZ) when there is only one macro to be 
> tested for.

I'm not sure that we care enough to put it into CodingStyle.

-- 
~Randy
