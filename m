Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030234AbVINWYg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030234AbVINWYg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Sep 2005 18:24:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030236AbVINWYg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Sep 2005 18:24:36 -0400
Received: from cpc1-cmbg6-5-0-cust20.cmbg.cable.ntl.com ([81.104.210.20]:37578
	"EHLO localhost.localdomain") by vger.kernel.org with ESMTP
	id S1030235AbVINWYg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Sep 2005 18:24:36 -0400
Subject: Re: [PATCH] Remove drivers/parport/parport_arc.c
From: Phil Blundell <philb@gnu.org>
To: Ian Molton <spyro@f2s.com>
Cc: Andrew Morton <akpm@osdl.org>, Russell King <rmk+lkml@arm.linux.org.uk>,
       adobriyan@gmail.com, domen@coderock.org, linux-kernel@vger.kernel.org
In-Reply-To: <43289932.7090604@f2s.com>
References: <20050914202420.GK19491@mipter.zuzino.mipt.ru>
	 <20050914220837.D30746@flint.arm.linux.org.uk>
	 <20050914141631.1567758b.akpm@osdl.org>  <43289932.7090604@f2s.com>
Content-Type: text/plain
Date: Wed, 14 Sep 2005 23:24:11 +0100
Message-Id: <1126736651.11120.2.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-09-14 at 22:42 +0100, Ian Molton wrote:
> Well unless the parport stuff changed to support ports where one cant 
> read the data latch, its still needed. 

I'm not sure I understand what you mean by that.  Can you explain what
sort of potential changes to the "parport stuff" you were thinking of?

p.


