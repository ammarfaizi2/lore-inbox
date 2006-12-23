Return-Path: <linux-kernel-owner+w=401wt.eu-S1753849AbWLWWqy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753849AbWLWWqy (ORCPT <rfc822;w@1wt.eu>);
	Sat, 23 Dec 2006 17:46:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753839AbWLWWqy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Dec 2006 17:46:54 -0500
Received: from agminet01.oracle.com ([141.146.126.228]:24480 "EHLO
	agminet01.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753799AbWLWWqy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Dec 2006 17:46:54 -0500
Date: Sat, 23 Dec 2006 14:41:03 -0800
From: Randy Dunlap <randy.dunlap@oracle.com>
To: Steve French <smfltc@us.ibm.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.19-rc1 build problem
Message-Id: <20061223144103.748d9d6c.randy.dunlap@oracle.com>
In-Reply-To: <458D8E38.4090303@us.ibm.com>
References: <458D8E38.4090303@us.ibm.com>
Organization: Oracle Linux Eng.
X-Mailer: Sylpheed version 2.2.9 (GTK+ 2.8.10; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Whitelist: TRUE
X-Whitelist: TRUE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 23 Dec 2006 14:14:48 -0600 Steve French wrote:

> Is this a know problem with very current 2.6.19-rc?

Do you mean 2.6.20-rc1?

> Building modules, stage 2.
> MODPOST 443 modules
> WARNING: "bitrev32" [drivers/net/8139cp.ko] undefined!
> WARNING: "serio_register_driver" [drivers/input/touchscreen/mtouch.ko] 
> undefined!
> (repeated many times)

I haven't seen it.  Got .config?

---
~Randy
