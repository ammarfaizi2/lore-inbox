Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315748AbSHHHJo>; Thu, 8 Aug 2002 03:09:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316047AbSHHHJo>; Thu, 8 Aug 2002 03:09:44 -0400
Received: from dell-paw-3.cambridge.redhat.com ([195.224.55.237]:25587 "EHLO
	passion.cambridge.redhat.com") by vger.kernel.org with ESMTP
	id <S315748AbSHHHJn>; Thu, 8 Aug 2002 03:09:43 -0400
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
From: David Woodhouse <dwmw2@infradead.org>
X-Accept-Language: en_GB
In-Reply-To: <Pine.LNX.4.33.0208071522570.21045-100000@rancor.yyz.somanetworks.com> 
References: <Pine.LNX.4.33.0208071522570.21045-100000@rancor.yyz.somanetworks.com> 
To: "Scott Murray" <scottm@somanetworks.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: RFC: PCI hotplug resource reservation 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Thu, 08 Aug 2002 08:13:22 +0100
Message-ID: <27462.1028790802@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


scottm@somanetworks.com said:
> I think the implications are pretty strong that programming bridges
> with conflicting ranges will result in undefined behaviour.  Even if
> it did work, doing so also has the potential to open us up to new
> classes of bridge hardware bugs that no one has seen before. 

OK. That buggers that idea then :(

--
dwmw2


