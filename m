Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312754AbSDBDXY>; Mon, 1 Apr 2002 22:23:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312752AbSDBDXO>; Mon, 1 Apr 2002 22:23:14 -0500
Received: from chamber.cco.caltech.edu ([131.215.48.55]:16572 "EHLO
	chamber.cco.caltech.edu") by vger.kernel.org with ESMTP
	id <S312754AbSDBDW7>; Mon, 1 Apr 2002 22:22:59 -0500
Message-ID: <3CA923FF.9060408@bryanr.org>
Date: Mon, 01 Apr 2002 19:22:39 -0800
From: Bryan Rittmeyer <bryanr@bryanr.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.8) Gecko/20020214
X-Accept-Language: en
MIME-Version: 1.0
To: Luis Falcon <lfalcon@thymbra.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: IRQ routing conflicts / Assigning IRQ 0 to ethernet
In-Reply-To: <1017704252.20857.7.camel@abyss>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

try the latest acpi patch from http://sf.net/projects/acpi/

-Bryan

Luis Falcon wrote:
> The main problem is that it can't assign an interrupt for the
> controller, plus I get irq routing conflicts on other devices...

