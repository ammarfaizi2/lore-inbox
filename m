Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261684AbVGDVdh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261684AbVGDVdh (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Jul 2005 17:33:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261687AbVGDVdg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Jul 2005 17:33:36 -0400
Received: from wproxy.gmail.com ([64.233.184.194]:31682 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261684AbVGDVcS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Jul 2005 17:32:18 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=JbitTooT6FWTmGaAiBXwrhLm0Z+FJ83sCFDfNG8bzGcMRmLrxmJDKT1hL7IzpF3RlxvNObgb/hBeNld+3H1Yn7IsbTLVDGfWuJAjonvmZd2+g3Sf1TjS18WQNWegfcX+Af+PulxSbNDHIfoauUpv+TXdr9iu02OULFUDGOMTpkE=
From: Alexey Dobriyan <adobriyan@gmail.com>
To: Marko Kohtala <marko.kohtala@gmail.com>
Subject: Re: IRQ routing problem
Date: Tue, 5 Jul 2005 01:38:51 +0400
User-Agent: KMail/1.8.1
Cc: linux-kernel@vger.kernel.org
References: <9cfa10eb05070304167e1cd051@mail.gmail.com>
In-Reply-To: <9cfa10eb05070304167e1cd051@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200507050138.51948.adobriyan@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 03 July 2005 15:16, Marko Kohtala wrote:
> irq 20: nobody cared (try booting with the "irqpoll" option)

I've filed a bug at kernel bugzilla so your report won't be lost.
See http://bugme.osdl.org/show_bug.cgi?id=4843

You can register at http://bugme.osdl.org/createaccount.cgi and add yourself
to CC list.
