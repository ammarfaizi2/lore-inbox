Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751021AbWEXO4h@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751021AbWEXO4h (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 May 2006 10:56:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932154AbWEXO4h
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 May 2006 10:56:37 -0400
Received: from relay4.usu.ru ([194.226.235.39]:4295 "EHLO relay4.usu.ru")
	by vger.kernel.org with ESMTP id S1751021AbWEXO4g (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 May 2006 10:56:36 -0400
Message-ID: <44747432.1090906@ums.usu.ru>
Date: Wed, 24 May 2006 20:56:50 +0600
From: "Alexander E. Patrakov" <patrakov@ums.usu.ru>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; ru-RU; rv:1.8.0.2) Gecko/20060405 SeaMonkey/1.0.1
MIME-Version: 1.0
To: Jon Smirl <jonsmirl@gmail.com>
Cc: Helge Hafting <helge.hafting@aitel.hist.no>,
       "D. Hazelton" <dhazelton@enter.net>,
       Manu Abraham <abraham.manu@gmail.com>, linux cbon <linuxcbon@yahoo.fr>,
       Valdis.Kletnieks@vt.edu, linux-kernel@vger.kernel.org
Subject: Re: OpenGL-based framebuffer concepts
References: <20060519224056.37429.qmail@web26611.mail.ukl.yahoo.com>	 <44700ACC.8070207@gmail.com>	 <A78F7AE7-C3C2-43DA-9F17-D196CCA7632A@mac.com>	 <200605230048.14708.dhazelton@enter.net>	 <9e4733910605231017g146e16dfnd61eb22a72bd3f5f@mail.gmail.com>	 <6896241F-3389-4B20-9E42-3CCDDBFDD312@mac.com>	 <44740533.7040702@aitel.hist.no> <447465C6.3090501@ums.usu.ru> <9e4733910605240749r1ce9e9fehcfffb2f2e3aeab60@mail.gmail.com>
In-Reply-To: <9e4733910605240749r1ce9e9fehcfffb2f2e3aeab60@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiVirus: checked by AntiVir MailGate (version: 2.0.1.15; AVE: 6.34.1.32; VDF: 6.34.1.138; host: usu2.usu.ru)
X-AV-Checked: ClamAV using ClamSMTP@relay4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jon Smirl wrote:
> You can't change the mode, instead you have to track it and use the
> one that is already set.

OK, this doesn't change my other point: use in-kernel text output facility for 
panics only.

-- 
Alexander E. Patrakov
