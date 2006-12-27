Return-Path: <linux-kernel-owner+w=401wt.eu-S932777AbWL0ViV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932777AbWL0ViV (ORCPT <rfc822;w@1wt.eu>);
	Wed, 27 Dec 2006 16:38:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932787AbWL0ViV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Dec 2006 16:38:21 -0500
Received: from homer.mvista.com ([63.81.120.158]:44240 "EHLO
	gateway-1237.mvista.com" rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org
	with ESMTP id S932777AbWL0ViU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Dec 2006 16:38:20 -0500
Subject: Re: [PATCH -rt] update kmap_atomic on !HIGHMEM
From: Daniel Walker <dwalker@mvista.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20061227213150.GA15638@elte.hu>
References: <20061227193550.324850000@mvista.com>
	 <20061227212555.GA14947@elte.hu>  <20061227213150.GA15638@elte.hu>
Content-Type: text/plain
Date: Wed, 27 Dec 2006 13:37:37 -0800
Message-Id: <1167255457.14081.47.camel@imap.mvista.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.3 (2.6.3-1.fc5.5) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-12-27 at 22:31 +0100, Ingo Molnar wrote:
> plus on i386 the fix below is needed as well.
> 

We do it on most other arches .. PowerPC , and I think ARM too.

Daniel

