Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265313AbUEVBSL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265313AbUEVBSL (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 May 2004 21:18:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265146AbUEVBOf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 May 2004 21:14:35 -0400
Received: from hell.org.pl ([212.244.218.42]:61701 "HELO hell.org.pl")
	by vger.kernel.org with SMTP id S264488AbUEVBOD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 May 2004 21:14:03 -0400
Date: Fri, 21 May 2004 08:27:30 +0200
From: Karol Kozimor <sziwan@hell.org.pl>
To: mru@kth.se, linux-kernel@vger.kernel.org
Subject: Re: ACPI interrupts on Asus
Message-ID: <20040521062729.GA7119@hell.org.pl>
References: <20040521030255.GA16390@mcelrath.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
In-Reply-To: <20040521030255.GA16390@mcelrath.org>
User-Agent: Mutt/1.4.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thus wrote Bob McElrath:
> You both indicated on the LKML list that you have an ASUS laptop and
> after a suspend, ACPI interrupts are not received.  It seems no
> resolution to this is posted on the LKML list.  Have either of you
> figured out how to fix this?

http://bugme.osdl.org/show_bug.cgi?id=2321 has a working solution.
Best regards,

-- 
Karol 'sziwan' Kozimor
sziwan@hell.org.pl
