Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264695AbTGGFrt (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Jul 2003 01:47:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264709AbTGGFrt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Jul 2003 01:47:49 -0400
Received: from e34.co.us.ibm.com ([32.97.110.132]:56260 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S264695AbTGGFrs
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Jul 2003 01:47:48 -0400
Message-ID: <3F090C28.4080405@us.ibm.com>
Date: Sun, 06 Jul 2003 22:59:04 -0700
From: Nivedita Singhvi <niv@us.ibm.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.2.1) Gecko/20021130
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Nivedita Singhvi <niv@us.ibm.com>
CC: Paul Albrecht <palbrecht@qwest.net>, linux-kernel@vger.kernel.org,
       netdev <netdev@oss.sgi.com>
Subject: Re: question about linux tcp request queue handling
References: <3F08858E.8000907@us.ibm.com> <001a01c3441c$6fe111a0$6801a8c0@oemcomputer> <3F08B7E2.7040208@us.ibm.com> <000d01c3444f$e6439600$6801a8c0@oemcomputer> <3F090A4F.10004@us.ibm.com>
In-Reply-To: <3F090A4F.10004@us.ibm.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nivedita Singhvi wrote:

> Er, complete the 3 way handshake? If the client gets the syn/ack, it
> should send a SYN in response, and move to ESTABLISHED state. If the
		~~~

my bad, sorry, that should be ACK, of course...

thanks,
Nivedita

