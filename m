Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267451AbUJKHcT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267451AbUJKHcT (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Oct 2004 03:32:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267994AbUJKHcT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Oct 2004 03:32:19 -0400
Received: from village.ehouse.ru ([193.111.92.18]:59143 "EHLO mail.ehouse.ru")
	by vger.kernel.org with ESMTP id S267451AbUJKHcR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Oct 2004 03:32:17 -0400
From: "Sergey S. Kostyliov" <rathamahata@ehouse.ru>
Reply-To: "Sergey S. Kostyliov" <rathamahata@ehouse.ru>
To: "Mukker, Atul" <Atulm@lsil.com>
Subject: Re: Megaraid random loss of luns
Date: Mon, 11 Oct 2004 11:32:06 +0400
User-Agent: KMail/1.7
Cc: comsatcat@earthlink.net, linux-kernel@vger.kernel.org, gluk@php4.ru
References: <0E3FA95632D6D047BA649F95DAB60E57033BCAE3@exa-atlanta>
In-Reply-To: <0E3FA95632D6D047BA649F95DAB60E57033BCAE3@exa-atlanta>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200410111132.07462.rathamahata@ehouse.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 11 October 2004 08:04, Mukker, Atul wrote:
> 
> Are these problems suddenly start to popup?
Yes they are. Btw, the problem itself is not visible to the userspace,
there only messages in kernel log.
> Can you try changing the hardware in the following order scsi cables,
> disk enclosure, controller  
I'll try to follow your suggestion. It is not so easy, one machine
is remote. But what looks strange to me is:
1) I upgraded to 2.20.4.0 two machines, one is LSI megaraid 320-1,
other is AMI megaraid 160 (series 475).
2) The messages in kernel log I had never seen before appeared on both
of two machines.

-- 
Sergey S. Kostyliov <rathamahata@ehouse.ru>
Jabber ID: rathamahata@jabber.org
