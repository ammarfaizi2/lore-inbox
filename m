Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262631AbVCWAaY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262631AbVCWAaY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Mar 2005 19:30:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262655AbVCWAaY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Mar 2005 19:30:24 -0500
Received: from relay02.mail-hub.dodo.com.au ([202.136.32.45]:59115 "EHLO
	relay02.mail-hub.dodo.com.au") by vger.kernel.org with ESMTP
	id S262631AbVCWAaU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Mar 2005 19:30:20 -0500
From: Grant Coady <grant_nospam@dodo.com.au>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.30-rc1
Date: Wed, 23 Mar 2005 11:30:13 +1100
Organization: scattered.homelinux.net
Message-ID: <f9d141l8qn8od1lsnmb31snv94pjm8eldp@4ax.com>
References: <20050318215513.GA25936@logos.cnet>
In-Reply-To: <20050318215513.GA25936@logos.cnet>
X-Mailer: Forte Agent 2.0/32.652
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marcelo,

On Fri, 18 Mar 2005 18:55:13 -0300, Marcelo Tosatti <marcelo.tosatti@cyclades.com> wrote:
>
>
>Here goes the first release candidate for v2.4.30. 

drivers/pci/pci.ids is lagging http://pciids.sourceforge.net/pci.ids
by a fair amount, >6300 lines diff 

I don't know policy on this reference, just tracked a change in kernel 
didn't reflect in lspci and discovered kernel and pciutils have their 
own copies of pci.ids file.

Grant.

