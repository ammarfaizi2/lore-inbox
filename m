Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932211AbWHVMkU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932211AbWHVMkU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Aug 2006 08:40:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932212AbWHVMkU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Aug 2006 08:40:20 -0400
Received: from gwmail.nue.novell.com ([195.135.221.19]:35470 "EHLO
	emea5-mh.id5.novell.com") by vger.kernel.org with ESMTP
	id S932211AbWHVMkT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Aug 2006 08:40:19 -0400
Message-Id: <44EB176A.76E4.0078.0@novell.com>
X-Mailer: Novell GroupWise Internet Agent 7.0.1 
Date: Tue, 22 Aug 2006 14:40:42 +0200
From: "Jan Beulich" <jbeulich@novell.com>
To: "Andi Kleen" <ak@suse.de>
Cc: "J. Bruce Fields" <bfields@fieldses.org>, "Andrew Morton" <akpm@osdl.org>,
       <linux-kernel@vger.kernel.org>, "Randy.Dunlap" <rdunlap@xenotime.net>
Subject: Re: boot failure, "DWARF2 unwinder stuck at 0xc0100199"
References: <20060820013121.GA18401@fieldses.org>
 <20060821212043.332fdd0f.akpm@osdl.org> <44EAD613.76E4.0078.0@novell.com>
 <200608221022.59255.ak@suse.de> <44EADD1A.76E4.0078.0@novell.com>
 <20060822103415.848a88de.ak@suse.de>
In-Reply-To: <20060822103415.848a88de.ak@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> and the bottom-of-stack annotations.
>
>You mean the push $0s to terminate the stack or something else?

Yes.
