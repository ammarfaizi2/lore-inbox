Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750819AbWCONtN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750819AbWCONtN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Mar 2006 08:49:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751878AbWCONtM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Mar 2006 08:49:12 -0500
Received: from [81.2.110.250] ([81.2.110.250]:56737 "EHLO lxorguk.ukuu.org.uk")
	by vger.kernel.org with ESMTP id S1750819AbWCONtM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Mar 2006 08:49:12 -0500
Subject: Re: PATCH: rio driver rework continued  #1
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Arjan van de Ven <arjan@infradead.org>
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org
In-Reply-To: <1142425465.3021.22.camel@laptopd505.fenrus.org>
References: <1142425052.5597.3.camel@localhost.localdomain>
	 <1142425465.3021.22.camel@laptopd505.fenrus.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Wed, 15 Mar 2006 13:55:26 +0000
Message-Id: <1142430926.5597.37.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mer, 2006-03-15 at 13:24 +0100, Arjan van de Ven wrote:
> > +typedef u8 BYTE;
> > +typedef u16 WORD;
> > +typedef u32 DWORD;
> 
> 
> while you're there... might as well kill those ;)

There is a lot more than that left on the todo list. You can only shovel
so much manure in a day ;)

