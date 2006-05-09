Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751462AbWEIOtp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751462AbWEIOtp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 May 2006 10:49:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751757AbWEIOtp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 May 2006 10:49:45 -0400
Received: from dvhart.com ([64.146.134.43]:63202 "EHLO dvhart.com")
	by vger.kernel.org with ESMTP id S1751462AbWEIOto (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 May 2006 10:49:44 -0400
Message-ID: <4460AC01.5020503@mbligh.org>
Date: Tue, 09 May 2006 07:49:37 -0700
From: "Martin J. Bligh" <mbligh@mbligh.org>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051013)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Chris Wright <chrisw@sous-sol.org>
Cc: linux-kernel@vger.kernel.org, virtualization@lists.osdl.org,
       xen-devel@lists.xensource.com
Subject: Re: [RFC PATCH 00/35] Xen i386 paravirtualization support
References: <20060509084945.373541000@sous-sol.org>
In-Reply-To: <20060509084945.373541000@sous-sol.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Congrats on getting this thrashed out. A few comments, most of which are
boring style nits, but nonetheless ... will try to take a proper look
later.

General comment:

Why is this style used:

HYPERVISOR_foo_bar ?

ie the capitalization of HYPERVISOR. Doesn't seem to fit with the rest
of the kernel style.

