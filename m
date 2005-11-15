Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932186AbVKOBEJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932186AbVKOBEJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Nov 2005 20:04:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932266AbVKOBEI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Nov 2005 20:04:08 -0500
Received: from mx2.suse.de ([195.135.220.15]:1997 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S932186AbVKOBEH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Nov 2005 20:04:07 -0500
From: Andi Kleen <ak@suse.de>
To: discuss@x86-64.org, george@mvista.com
Subject: Re: [discuss] Re: [PATCH 13/39] NLKD/x86-64 - time adjustment
Date: Tue, 15 Nov 2005 02:05:24 +0100
User-Agent: KMail/1.8.2
Cc: Vojtech Pavlik <vojtech@suse.cz>, Jan Beulich <JBeulich@novell.com>,
       linux-kernel@vger.kernel.org
References: <43720DAE.76F0.0078.0@novell.com> <20051112204428.GA14733@midnight.suse.cz> <43792DFF.1000300@mvista.com>
In-Reply-To: <43792DFF.1000300@mvista.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200511150205.25339.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 15 November 2005 01:38, George Anzinger wrote:

> Doesn't this depend on the atomic nature of the 64-bit read?  If it is really two 32-bit reads one 
> would need to do extra work to make sure the two parts belong together.

Please take a look at the Subject.

-Andi
