Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267563AbUIULHw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267563AbUIULHw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Sep 2004 07:07:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267565AbUIULHw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Sep 2004 07:07:52 -0400
Received: from 168.imtp.Ilyichevsk.Odessa.UA ([195.66.192.168]:64016 "HELO
	port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with SMTP
	id S267563AbUIULHt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Sep 2004 07:07:49 -0400
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
To: Linas Vepstas <linas@austin.ibm.com>
Subject: Re: [PATCH] [PPC64] [TRIVIAL] Janitor whitespace in pSeries_pci.c
Date: Tue, 21 Sep 2004 14:07:09 +0300
User-Agent: KMail/1.5.4
Cc: paulus@samba.org, linux-kernel@vger.kernel.org, anton@samba.org
References: <20040920221933.GB1872@austin.ibm.com> <20040920223121.GC1872@austin.ibm.com>
In-Reply-To: <20040920223121.GC1872@austin.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="koi8-r"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200409211407.09764.vda@port.imtp.ilyichevsk.odessa.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 21 September 2004 01:31, Linas Vepstas wrote:
> 
> Forgot to attach the actual patch.
> 
> On Mon, Sep 20, 2004 at 05:19:33PM -0500, Linas Vepstas was heard to remark:
> > Hi,
> 
> 
> This file mixes tabs with 8 spaces, leading to poor display 
> if one's editor doesn't have tab-stops set to 8.   Please apply.

There are lots of such places.
Automated scripts can easily produce megabytes worth of whitespace
patches.

As I understand, such patches aren't accepted because
merging pain is much greater than gain.
Typically whitespace cleanups are piggybacked on some code changes.
--
vda

