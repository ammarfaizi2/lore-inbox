Return-Path: <linux-kernel-owner+w=401wt.eu-S1750716AbXAIBP6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750716AbXAIBP6 (ORCPT <rfc822;w@1wt.eu>);
	Mon, 8 Jan 2007 20:15:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750726AbXAIBP6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Jan 2007 20:15:58 -0500
Received: from quechua.inka.de ([193.197.184.2]:39574 "EHLO mail.inka.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750716AbXAIBP5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Jan 2007 20:15:57 -0500
From: Bernd Eckenfels <ecki@lina.inka.de>
To: linux-kernel@vger.kernel.org
Subject: Re: Strange ethN numbering problem.
Organization: Private Site running Debian GNU/Linux
In-Reply-To: <45A2E19F.4070307@metricsystems.com>
X-Newsgroups: ka.lists.linux.kernel
User-Agent: tin/1.7.8-20050315 ("Scalpay") (UNIX) (Linux/2.6.13.4 (i686))
Message-Id: <E1H45al-0002Xj-00@calista.eckenfels.net>
Date: Tue, 09 Jan 2007 02:15:55 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <45A2E19F.4070307@metricsystems.com> you wrote:
> However, when the system comes up and attempt to do an ifconfig, the 
> 'ethN' numbers
> have changed to a some what intermengled seriese starting with eth6... 
> eth10.

maybe a system startup script is renaming them (in order to give them well
known numbers)? 

What kind of distribution is that? is this a new problem? Have a look in
/etc/mactab.

Gruss
Bernd
