Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262437AbVA0AHH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262437AbVA0AHH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Jan 2005 19:07:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262156AbVA0AGA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Jan 2005 19:06:00 -0500
Received: from fw.osdl.org ([65.172.181.6]:64438 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262437AbVAZVZE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Jan 2005 16:25:04 -0500
Date: Wed, 26 Jan 2005 13:25:04 -0800
From: Stephen Hemminger <shemminger@osdl.org>
To: Martin Josefsson <gandalf@wlug.westbo.se>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [Bug 4081] New: OpenOffice crashes while starting due to a  
 threading error
Message-ID: <20050126132504.3295e07d@dxpl.pdx.osdl.net>
In-Reply-To: <1106482954.1256.2.camel@tux.rsn.bth.se>
References: <217740000.1106412985@[10.10.2.4]>
	<41F30E0A.9000100@osdl.org>
	<1106482954.1256.2.camel@tux.rsn.bth.se>
Organization: Open Source Development Lab
X-Mailer: Sylpheed-Claws 0.9.13 (GTK+ 1.2.10; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On my laptop with Fedora Core 3, OpenOffice 1.0.1, 1.0.4 and the pre 2.0 version
all work fine running 2.6.10-FCxx kernel but get a SEGV when running on 2.6.11-rc1 or 2.6.11-rc2

Any hints?


-- 
Stephen Hemminger	<shemminger@osdl.org>
