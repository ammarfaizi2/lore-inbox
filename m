Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262226AbUKKMNP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262226AbUKKMNP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Nov 2004 07:13:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262224AbUKKMNO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Nov 2004 07:13:14 -0500
Received: from grendel.digitalservice.pl ([217.67.200.140]:41166 "HELO
	mail.digitalservice.pl") by vger.kernel.org with SMTP
	id S262226AbUKKMNL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Nov 2004 07:13:11 -0500
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.10-rc1-mm5: yenta_socket issue
Date: Thu, 11 Nov 2004 13:11:44 +0100
User-Agent: KMail/1.6.2
Cc: linux-kernel@vger.kernel.org
References: <20041111012333.1b529478.akpm@osdl.org>
In-Reply-To: <20041111012333.1b529478.akpm@osdl.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Message-Id: <200411111311.44664.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 11 of November 2004 10:23, Andrew Morton wrote:
> 
> 
ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.10-rc1/2.6.10-rc1-mm5/

On an AMD64 box (Athlon 64 + NForce3) I get these messages from yenta_socket:

yenta_socket: Unknown symbol dead_socket
yenta_socket: Unknown symbol pcmcia_register_socket
yenta_socket: Unknown symbol pcmcia_socket_dev_resume
yenta_socket: Unknown symbol pcmcia_parse_events
yenta_socket: Unknown symbol pcmcia_socket_dev_suspend
yenta_socket: Unknown symbol pcmcia_unregister_socket

but the module loads.

Greets,
RJW

-- 
- Would you tell me, please, which way I ought to go from here?
- That depends a good deal on where you want to get to.
		-- Lewis Carroll "Alice's Adventures in Wonderland"
