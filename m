Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932274AbVJKScw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932274AbVJKScw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Oct 2005 14:32:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932275AbVJKScv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Oct 2005 14:32:51 -0400
Received: from smtp.osdl.org ([65.172.181.4]:50576 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932274AbVJKScu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Oct 2005 14:32:50 -0400
Date: Tue, 11 Oct 2005 11:32:06 -0700
From: Andrew Morton <akpm@osdl.org>
To: Adam Litke <agl@us.ibm.com>
Cc: agl@us.ibm.com, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
       david@gibson.dropbear.id.au, ak@suse.de, hugh@veritas.com
Subject: Re: [PATCH 0/3] Demand faulting for hugetlb
Message-Id: <20051011113206.77e0fc84.akpm@osdl.org>
In-Reply-To: <1129055057.22182.8.camel@localhost.localdomain>
References: <1129055057.22182.8.camel@localhost.localdomain>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adam Litke <agl@us.ibm.com> wrote:
>
> Andrew: Did Andi
>  Kleen's explanation of huge_pages_needed() satisfy?

Spose so.  I trust that it's adequately commented in this version..
