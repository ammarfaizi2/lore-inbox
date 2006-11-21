Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1031395AbWKUUYL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031395AbWKUUYL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Nov 2006 15:24:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031397AbWKUUYK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Nov 2006 15:24:10 -0500
Received: from mx1.suse.de ([195.135.220.2]:18665 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1031395AbWKUUYJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Nov 2006 15:24:09 -0500
From: Andi Kleen <ak@suse.de>
To: David Rientjes <rientjes@cs.washington.edu>
Subject: Re: arch/x86_64/kernel/apic.c(701): remark #593: variable "ver" was set but never us
Date: Tue, 21 Nov 2006 21:22:05 +0100
User-Agent: KMail/1.9.5
Cc: d binderman <dcb314@hotmail.com>, Ingo Molnar <mingo@redhat.com>,
       linux-kernel@vger.kernel.org
References: <BAY107-F214E963C5A93489762562E9CEC0@phx.gbl> <Pine.LNX.4.64N.0611211214230.25455@attu4.cs.washington.edu>
In-Reply-To: <Pine.LNX.4.64N.0611211214230.25455@attu4.cs.washington.edu>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200611212122.05462.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 21 November 2006 21:18, David Rientjes wrote:
> Remove unused GET_APIC_VERSION call from clear_local_APIC() and 
> __setup_APIC_LVTT().
> 
> Reported by D Binderman <dcb314@hotmail.com>.

Added thanks.


-Andi
