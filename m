Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262288AbTIHMmt (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Sep 2003 08:42:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262301AbTIHMmt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Sep 2003 08:42:49 -0400
Received: from main.gmane.org ([80.91.224.249]:33445 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S262288AbTIHMms (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Sep 2003 08:42:48 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: =?ISO-8859-1?Q?Sven_K=F6hler?= <skoehler@upb.de>
Subject: Re: [BUG?] usb won't work with kernel 2.4.22
Date: Mon, 08 Sep 2003 14:38:37 +0200
Message-ID: <bjhtg3$7pm$1@sea.gmane.org>
References: <mnet3.1062999418.2284.pinotj@club-internet.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Complaints-To: usenet@sea.gmane.org
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.5b) Gecko/20030827
X-Accept-Language: de, en
In-Reply-To: <mnet3.1062999418.2284.pinotj@club-internet.fr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I got the same probleme with K7S5A/SiS735 and it doesn't come from USB.
> I found that the acpi upgrade between 2.4.22-rc2 and 2.4.22-rc3 break the USB detection. I made a fall-back diff about this.
> I discussed about this with Andrew de Quincey on acpi mailing-list. His last acpi global patch correct this problem too but I don't know if it will be implemented.

Well, Thx. I've got the same board (K7S5A), so it should work for me too.


