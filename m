Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261676AbUJYG3Y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261676AbUJYG3Y (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Oct 2004 02:29:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261675AbUJYG3X
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Oct 2004 02:29:23 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:43912 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S261629AbUJYG2g
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Oct 2004 02:28:36 -0400
Message-ID: <417C9D08.6030903@pobox.com>
Date: Mon, 25 Oct 2004 02:28:24 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040922
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "David S. Miller" <davem@davemloft.net>
CC: linux-kernel@vger.kernel.org, netdev@oss.sgi.com
Subject: Re: [NET]: TSO requires SG, enforce this at device registry.
References: <200410221715.i9MHFlIu021927@hera.kernel.org>	<417C9431.6030505@pobox.com> <20041024225700.4a22a968.davem@davemloft.net>
In-Reply-To: <20041024225700.4a22a968.davem@davemloft.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David S. Miller wrote:
> On Mon, 25 Oct 2004 01:50:41 -0400
> Jeff Garzik <jgarzik@pobox.com> wrote:
> 
> 
>>1) Given current driver implementations of ethtool ioctls, sysadmin is 
>>free to create a combination of bits that are IMHO a bug.  One can argue 
>>that this is an extension of "root can shoot himself in the foot", so 
>>who knows.
> 
> 
> I made a followon posting proposing ethtool changes which
> would enforce the rules there too, did you see it?


Sorry, I didn't see it.  URL or grep string?

	Jeff


