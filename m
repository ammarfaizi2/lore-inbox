Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270461AbTGXElI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Jul 2003 00:41:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270483AbTGXElI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Jul 2003 00:41:08 -0400
Received: from adsl-67-114-19-186.dsl.pltn13.pacbell.net ([67.114.19.186]:35773
	"HELO adsl-63-202-77-221.dsl.snfc21.pacbell.net") by vger.kernel.org
	with SMTP id S270461AbTGXElG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Jul 2003 00:41:06 -0400
Message-ID: <3F1F66F0.1050406@tupshin.com>
Date: Wed, 23 Jul 2003 21:56:16 -0700
From: Tupshin Harper <tupshin@tupshin.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5a) Gecko/20030618
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Shawn <core@enodev.com>
CC: Hans Reiser <reiser@namesys.com>,
       "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
       reiserfs mailing list <reiserfs-list@namesys.com>
Subject: Re: Reiser4 status: benchmarked vs. V3 (and ext3)
References: <3F1EF7DB.2010805@namesys.com>  <3F1F6005.4060307@tupshin.com> <1059021113.7911.13.camel@localhost>
In-Reply-To: <1059021113.7911.13.camel@localhost>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Shawn wrote:

>This is pretty f'ed, but it's on ftp://ftp.namesys.com/pub/tmp
>
Thanks, but I tried applying the
2.6.0-test1-reiser4-2.6.0-test1.diff from that location with a lack of 
success.

It applied cleanly, but it doesn't add a fs/reiser4 directory and 
asociated contents. Is there an additional patch, or is this one broken?

-Tupshin

