Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262030AbVAYRQo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262030AbVAYRQo (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Jan 2005 12:16:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262036AbVAYRQm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Jan 2005 12:16:42 -0500
Received: from pimout1-ext.prodigy.net ([207.115.63.77]:27102 "EHLO
	pimout1-ext.prodigy.net") by vger.kernel.org with ESMTP
	id S262030AbVAYROe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Jan 2005 12:14:34 -0500
Date: Tue, 25 Jan 2005 09:13:50 -0800
From: Chris Wedgwood <cw@f00f.org>
To: Anton Blanchard <anton@samba.org>
Cc: akpm@osdl.org, nickpiggin@yahoo.com.au, linux-kernel@vger.kernel.org,
       spyro@f2s.com
Subject: Re: [PATCH] Use MM_VM_SIZE in exit_mmap
Message-ID: <20050125171350.GA18433@taniwha.stupidest.org>
References: <20050125142210.GI5920@krispykreme.ozlabs.ibm.com> <20050125164642.GA17927@taniwha.stupidest.org> <20050125165745.GA27433@krispykreme.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050125165745.GA27433@krispykreme.ozlabs.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 26, 2005 at 03:57:45AM +1100, Anton Blanchard wrote:

> > >  #ifndef MM_VM_SIZE

i didn't read carefull, so no it won't warn.... still, i don't like
that being there but that can wait i guess
