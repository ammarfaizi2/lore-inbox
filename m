Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261893AbVEPV21@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261893AbVEPV21 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 May 2005 17:28:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261891AbVEPV0Q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 May 2005 17:26:16 -0400
Received: from fire.osdl.org ([65.172.181.4]:38856 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261896AbVEPVYo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 May 2005 17:24:44 -0400
Date: Mon, 16 May 2005 14:25:04 -0700
From: Andrew Morton <akpm@osdl.org>
To: "Martin J. Bligh" <mbligh@mbligh.org>
Cc: linux-kernel@vger.kernel.org, Christoph Lameter <clameter@engr.sgi.com>
Subject: Re: 2.6.12-rc4-mm2 boot failure
Message-Id: <20050516142504.696b443b.akpm@osdl.org>
In-Reply-To: <735450000.1116277481@flay>
References: <735450000.1116277481@flay>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Martin J. Bligh" <mbligh@mbligh.org> wrote:
>
> PPC64 NUMA box. Maybe this is the same NUMA slab problem you were 
> hitting before ...

Probably.  Christoph, this patch has crossed the grief threshold - I'll
drop it.
