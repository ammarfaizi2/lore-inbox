Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964817AbVKOQLe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964817AbVKOQLe (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Nov 2005 11:11:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964827AbVKOQLe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Nov 2005 11:11:34 -0500
Received: from mx1.redhat.com ([66.187.233.31]:18880 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S964817AbVKOQLd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Nov 2005 11:11:33 -0500
Date: Tue, 15 Nov 2005 11:10:41 -0500
From: Dave Jones <davej@redhat.com>
To: Arjan van de Ven <arjan@infradead.org>
Cc: Zachary Amsden <zach@vmware.com>, Gerd Knorr <kraxel@suse.de>,
       Linus Torvalds <torvalds@osdl.org>, Pavel Machek <pavel@ucw.cz>,
       Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       "H. Peter Anvin" <hpa@zytor.com>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       Pratap Subrahmanyam <pratap@vmware.com>,
       Christopher Li <chrisl@vmware.com>,
       "Eric W. Biederman" <ebiederm@xmission.com>,
       Ingo Molnar <mingo@elte.hu>
Subject: Re: [PATCH 1/10] Cr4 is valid on some 486s
Message-ID: <20051115161041.GA1749@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Arjan van de Ven <arjan@infradead.org>,
	Zachary Amsden <zach@vmware.com>, Gerd Knorr <kraxel@suse.de>,
	Linus Torvalds <torvalds@osdl.org>, Pavel Machek <pavel@ucw.cz>,
	Andrew Morton <akpm@osdl.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Zwane Mwaikambo <zwane@arm.linux.org.uk>,
	Pratap Subrahmanyam <pratap@vmware.com>,
	Christopher Li <chrisl@vmware.com>,
	"Eric W. Biederman" <ebiederm@xmission.com>,
	Ingo Molnar <mingo@elte.hu>
References: <Pine.LNX.4.64.0511111218110.4627@g5.osdl.org> <20051113074241.GA29796@redhat.com> <Pine.LNX.4.64.0511131118020.3263@g5.osdl.org> <Pine.LNX.4.64.0511131210570.3263@g5.osdl.org> <4378A7F3.9070704@suse.de> <Pine.LNX.4.64.0511141118000.3263@g5.osdl.org> <4379ECC1.20005@suse.de> <437A0649.7010702@suse.de> <437A0710.4020107@vmware.com> <1132070764.2822.27.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1132070764.2822.27.camel@laptopd505.fenrus.org>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 15, 2005 at 05:06:03PM +0100, Arjan van de Ven wrote:
 
 > > You still need to preserve the originals so that you can patch in both 
 > > directions.  
 > 
 > why do you insist on both directions? That still sounds like real
 > overkill to me.

cpu hotplug going from UP to SMP ? :)

		Dave

