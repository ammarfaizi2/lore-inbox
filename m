Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262031AbUK3I73@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262031AbUK3I73 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Nov 2004 03:59:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262032AbUK3I6O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Nov 2004 03:58:14 -0500
Received: from wproxy.gmail.com ([64.233.184.193]:21430 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262028AbUK3I5q (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Nov 2004 03:57:46 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=HXW+LQEczzglC9ymgDjkGULYRhlI1HiQ8nFm4NVbrhZOvXWlbxWn7+o3aitIfIE8sGOZlYTq0xd9+MImeXnf0JjT+e2j1gICtO2L4pPLwLJ9+UxzWXtSsp2TlEZL8BfNIoPF8/PCikPobyd9qVFZjqvnHx+C0GSpDKST9AVqrNw=
Message-ID: <81b0412b041130005774dd27a5@mail.gmail.com>
Date: Tue, 30 Nov 2004 09:57:45 +0100
From: Alex Riesen <raa.lkml@gmail.com>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
To: David Woodhouse <dwmw2@infradead.org>
Subject: Re: [RFC] Splitting kernel headers and deprecating __KERNEL__
Cc: Linus Torvalds <torvalds@osdl.org>, Paul Mackerras <paulus@samba.org>,
       Greg KH <greg@kroah.com>, Matthew Wilcox <matthew@wil.cx>,
       David Howells <dhowells@redhat.com>, hch@infradead.org,
       aoliva@redhat.com, linux-kernel@vger.kernel.org,
       libc-hacker@sources.redhat.com
In-Reply-To: <81b0412b04113000087fc8391e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <19865.1101395592@redhat.com>
	 <20041125165433.GA2849@parcelfarce.linux.theplanet.co.uk>
	 <1101406661.8191.9390.camel@hades.cambridge.redhat.com>
	 <20041127032403.GB10536@kroah.com>
	 <16810.24893.747522.656073@cargo.ozlabs.ibm.com>
	 <Pine.LNX.4.58.0411281710490.22796@ppc970.osdl.org>
	 <1101721336.21273.6138.camel@baythorne.infradead.org>
	 <81b0412b04113000087fc8391e@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I should have read the whole thread before posting. My apologies, Linus
