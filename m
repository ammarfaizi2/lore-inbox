Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261172AbULOMiq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261172AbULOMiq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Dec 2004 07:38:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262340AbULOMiq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Dec 2004 07:38:46 -0500
Received: from aktion1.adns.de ([62.116.145.13]:33178 "EHLO aktion1.adns.de")
	by vger.kernel.org with ESMTP id S261172AbULOMio (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Dec 2004 07:38:44 -0500
Message-ID: <41C030D2.7080604@asbest-online.de>
Date: Wed, 15 Dec 2004 13:40:50 +0100
From: Sven Krohlas <sven@asbest-online.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8a6) Gecko/20041213
X-Accept-Language: de, de-at, de-de, de-li, de-lu, de-ch, en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: Understanding schedular and slab allocation
References: <3byuD-2Z8-7@gated-at.bofh.it>
In-Reply-To: <3byuD-2Z8-7@gated-at.bofh.it>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
X-Virus-Scan: smtp-vilter
X-SMTP-Vilter-Version: 1.1.4
X-SMTP-Vilter-Backend: vilter-clamd
X-SMTP-Vilter-Status: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,


> Can any one refer me any documentation to understand the schedular and
> slab allocation in the kernel.

I just had a talk about the slab allocator.
You can find my slides at http://krohlas.de/
They are in German, but the last slide contains all sources which
are mainly available online and are written in English.

I hope this will help you.

Btw: is anybody working on the slab allocator as described in Bonwicks
2001 paper?

cu
-- 
Gegen Softwarepatente, für eine freie Gesellschaft!
http://softwarepatente.com/
http://patinfo.ffii.org/
