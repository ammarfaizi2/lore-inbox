Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261857AbTDUSSg (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Apr 2003 14:18:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261860AbTDUSSg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Apr 2003 14:18:36 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:59661 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id S261857AbTDUSSe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Apr 2003 14:18:34 -0400
Message-ID: <3EA438B3.1010602@zytor.com>
Date: Mon, 21 Apr 2003 11:30:11 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
Organization: Zytor Communications
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20030225
X-Accept-Language: en, sv
MIME-Version: 1.0
To: "Perez-Gonzalez, Inaky" <inaky.perez-gonzalez@intel.com>
CC: "'Greg KH'" <greg@kroah.com>, "'karim@opersys.com'" <karim@opersys.com>,
       "'Martin Hicks'" <mort@wildopensource.com>,
       "'Daniel Stekloff'" <dsteklof@us.ibm.com>,
       "'Patrick Mochel'" <mochel@osdl.org>,
       "'Randy.Dunlap'" <rddunlap@osdl.org>, "'pavel@ucw.cz'" <pavel@ucw.cz>,
       "'jes@wildopensource.com'" <jes@wildopensource.com>,
       "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
       "'wildos@sgi.com'" <wildos@sgi.com>,
       "'Tom Zanussi'" <zanussi@us.ibm.com>
Subject: Re: [patch] printk subsystems
References: <A46BBDB345A7D5118EC90002A5072C780C263699@orsmsx116.jf.intel.com>
In-Reply-To: <A46BBDB345A7D5118EC90002A5072C780C263699@orsmsx116.jf.intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Perez-Gonzalez, Inaky wrote:
> 
> Hey! Come on! You don't think I am that lame, do you? Man what
> a fame I do have!
> 
> Before the device vaporizes, it recalls the message, so there is 
> no message to read - the same way you take away the sysfs data from
> the sysfs tree ...
> 

If you think that will happen with printk(), then, quite frankly, you're
seriously deluded.

	-hpa


