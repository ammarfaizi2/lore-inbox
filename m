Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S274723AbTHPPKh (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 16 Aug 2003 11:10:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S273909AbTHPPKh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Aug 2003 11:10:37 -0400
Received: from pimout3-ext.prodigy.net ([207.115.63.102]:19937 "EHLO
	pimout3-ext.prodigy.net") by vger.kernel.org with ESMTP
	id S274723AbTHPPKd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Aug 2003 11:10:33 -0400
Message-ID: <3F3DD93E.7090706@myrealbox.com>
Date: Sat, 16 Aug 2003 00:11:58 -0700
From: walt <wa1ter@myrealbox.com>
Organization: none
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030805
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: 2.6.0-test3 current - firewire compile error
References: <3F3E288B.3010105@cornell.edu>
In-Reply-To: <3F3E288B.3010105@cornell.edu>
X-Enigmail-Version: 0.76.4.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ivan Gyurdiev wrote:
> Hopefully, this is not a duplicate post:
> ===========================================
> 
> drivers/ieee1394/nodemgr.c: In function `nodemgr_update_ud_names':
> drivers/ieee1394/nodemgr.c:471: error: structure has no member named `name'

I got a similar error starting with last night's bk pull:

drivers/pnp/core.c: In function `pnp_register_protocol':
drivers/pnp/core.c:72: structure has no member named `name'

