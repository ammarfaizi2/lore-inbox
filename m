Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964828AbVJMVTx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964828AbVJMVTx (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Oct 2005 17:19:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964832AbVJMVTx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Oct 2005 17:19:53 -0400
Received: from qproxy.gmail.com ([72.14.204.193]:14692 "EHLO qproxy.gmail.com")
	by vger.kernel.org with ESMTP id S964828AbVJMVTx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Oct 2005 17:19:53 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:x-accept-language:mime-version:to:subject:content-type:content-transfer-encoding;
        b=pOlaxJp8BEoi+EPFwQH791oa/HtqCVS9cYShB1jBRPQXVxXeNhniYWJYd5990kowklgIg6kFkHpN8ySTY0shHtujxrK6xVo0NXbYaQPgHVcdh1/w8h5C9QwHHQy0/FRqHeZkThNtxDgFdIlnd6r4K12yI6w39r+loLfvrRoC7IM=
Message-ID: <434ECF66.3030101@gmail.com>
Date: Thu, 13 Oct 2005 23:19:34 +0200
From: =?ISO-8859-2?Q?=A3ukasz_Gromanowski?= <lgromanowski@gmail.com>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20050923)
X-Accept-Language: pl, en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Newbie problem with Gigabyte GA-K8U mainboard, ALi/ULi 1689 chipset
 and agpgart...
Content-Type: text/plain; charset=ISO-8859-2; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
i have computer with Gigabyte GA-K8U motherboard with ULi 1689 chipset
(northbridge):

http://tw.giga-byte.com/Motherboard/Products/Products_GA-K8U.htm#

I want enable 3d hardware acceleration for my ATI Radeon 9550 card
and i tried to compile new kernel 2.6.13 (vanilla from Slackware
current) with agpgart -> ALI chipset option enabled. But when
i run new kernel i saw agpgart error: "unsupported ALI chipset".
Could you help me with it, please? What agpgart module should
i choose instead of ALI? And another question - will
be ALi/ULi 1689 chipset supported in near future in kernel?

Sorry for my spelling errors - English is not my native language.

-
-- 
best regards,
Lukasz Gromanowski


