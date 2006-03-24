Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751565AbWCXH1z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751565AbWCXH1z (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Mar 2006 02:27:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751568AbWCXH1z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Mar 2006 02:27:55 -0500
Received: from smtp.osdl.org ([65.172.181.4]:45204 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751562AbWCXH1z (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Mar 2006 02:27:55 -0500
Date: Thu, 23 Mar 2006 23:23:45 -0800
From: Andrew Morton <akpm@osdl.org>
To: "David S. Miller" <davem@davemloft.net>
Cc: arjan@infradead.org, yang.y.yi@gmail.com, linux-kernel@vger.kernel.org,
       johnpol@2ka.mipt.ru, matthltc@us.ibm.com
Subject: Re: [2.6.16 PATCH] Connector: Filesystem Events Connector v3
Message-Id: <20060323232345.1ca16f3f.akpm@osdl.org>
In-Reply-To: <20060323.230649.11516073.davem@davemloft.net>
References: <4423673C.7000008@gmail.com>
	<1143183541.2882.7.camel@laptopd505.fenrus.org>
	<20060323.230649.11516073.davem@davemloft.net>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"David S. Miller" <davem@davemloft.net> wrote:
>
> From: Arjan van de Ven <arjan@infradead.org>
>  Date: Fri, 24 Mar 2006 07:59:01 +0100
> 
>  > then make the syslog part optional.. if it's not already!
> 
>  Regardless I still think the filesystem events connector is a useful
>  facility.

Why's that?

(I'd viewed it as a fun thing, but I haven't really seen much pull for it,
and the scalability issues in there aren't trivial).
