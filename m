Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265065AbTAAWZv>; Wed, 1 Jan 2003 17:25:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265081AbTAAWZv>; Wed, 1 Jan 2003 17:25:51 -0500
Received: from transport.cksoft.de ([62.111.66.27]:48399 "EHLO
	transport.cksoft.de") by vger.kernel.org with ESMTP
	id <S265065AbTAAWZu>; Wed, 1 Jan 2003 17:25:50 -0500
Date: Wed, 1 Jan 2003 22:29:52 +0000 (UTC)
From: "Bjoern A. Zeeb" <bzeeb-lists@lists.zabbadoz.net>
X-X-Sender: bz@e0-0.zab2.int.zabbadoz.net
To: Andi Kleen <ak@muc.de>
Cc: linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: 3rdparty modules for 2.5.53
In-Reply-To: <m3isx8em2c.fsf@averell.firstfloor.org>
Message-ID: <Pine.BSF.4.44.0301012221130.647-100000@e0-0.zab2.int.zabbadoz.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 1 Jan 2003, Andi Kleen wrote:

[new modules thing]

> P.S.: I agree that the error reporting sucks for this one. It would
> be better if the kernel loader give some kind of text message back.

I think we mainly lack of documentation. anybody really followed and
understood this thing or perhaps the author ;-) should
write a/update modules.txt for 'module writers' not for users:

- how to update old style to new style; what needs to be changed ?
- what needs to be done to build own modules outside kernel tree ?
- skeleton for new modules
- dos and dont's

Did I miss s.th. ?

-- 
Bjoern A. Zeeb				bzeeb at Zabbadoz dot NeT
56 69 73 69 74				http://www.zabbadoz.net/

