Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264436AbTLBXb2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Dec 2003 18:31:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264439AbTLBXb2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Dec 2003 18:31:28 -0500
Received: from port-212-202-185-245.reverse.qdsl-home.de ([212.202.185.245]:57006
	"EHLO gw.localnet") by vger.kernel.org with ESMTP id S264436AbTLBXbY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Dec 2003 18:31:24 -0500
Message-ID: <3FCD20F1.6090800@trash.net>
Date: Wed, 03 Dec 2003 00:32:01 +0100
From: Patrick McHardy <kaber@trash.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20031107 Debian/1.5-3
X-Accept-Language: en
MIME-Version: 1.0
To: Wilmer van der Gaast <lintux@lintux.cx>
CC: linux-kernel@vger.kernel.org,
       Netfilter Development Mailinglist 
	<netfilter-devel@lists.netfilter.org>
Subject: Re: 2.4.23 masquerading broken?
References: <20031202165653.GJ615@gaast.net> <3FCCCB02.5070203@trash.net> <20031202173358.GK615@gaast.net>
In-Reply-To: <20031202173358.GK615@gaast.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Wilmer van der Gaast wrote:

>Dec  2 16:42:57 tosca kernel: NET: 4 messages suppressed.
>Dec  2 16:42:57 tosca kernel: MASQUERADE: Route sent us somewhere else.
>
>And, well, it goes on like that. dmesg is full of messages like this.
>
>The packages seem to get lost completely. At least I don't see them
>going out on eth1 (where they should go to).
>
>  
>
It may be related to using advances routing features ..
Can you give information about the specific IPs ? Is it local traffic ?

Thanks,
Patrick

