Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263843AbTCWVWZ>; Sun, 23 Mar 2003 16:22:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263887AbTCWVWZ>; Sun, 23 Mar 2003 16:22:25 -0500
Received: from a089148.adsl.hansenet.de ([213.191.89.148]:20609 "EHLO
	ds666.starfleet") by vger.kernel.org with ESMTP id <S263843AbTCWVWY>;
	Sun, 23 Mar 2003 16:22:24 -0500
Message-ID: <3E7E282E.7070008@portrix.net>
Date: Sun, 23 Mar 2003 22:33:34 +0100
From: Jan Dittmer <j.dittmer@portrix.net>
Organization: portrix.net GmbH
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4a) Gecko/20030305
X-Accept-Language: en
MIME-Version: 1.0
To: Christoph Hellwig <hch@infradead.org>
CC: linux-kernel@vger.kernel.org, dominik@kubla.de, greg@kroah.com
Subject: Re: i2c-via686a driver
References: <3E7E0B37.5060505@portrix.net> <20030323202743.A11150@infradead.org> <200303232136.10089.dominik@kubla.de> <20030323204810.A11421@infradead.org>
In-Reply-To: <20030323204810.A11421@infradead.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Hellwig wrote:
> On Sun, Mar 23, 2003 at 09:36:10PM +0100, Dominik Kubla wrote:
> 
>>Why? It's a valid C99 feature and since the kernel already uses C99 
>>initializers it won't compile with compilers that choke on C99 comments 
>>anyway.
> 
> 
> Because there's a strong preference for traditional C style in the kernel.
> typedefs are also a valid C feature and we try to avoid them.
> 
I just copied the cvs driver without changing more than necessary. 
Shouldn't this be up to the lm_sensors folk?

Jan

