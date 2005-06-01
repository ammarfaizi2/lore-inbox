Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261387AbVFAOQ5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261387AbVFAOQ5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Jun 2005 10:16:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261203AbVFAOQ5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Jun 2005 10:16:57 -0400
Received: from mail.fh-wedel.de ([213.39.232.198]:56212 "EHLO
	moskovskaya.fh-wedel.de") by vger.kernel.org with ESMTP
	id S261387AbVFAOKY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Jun 2005 10:10:24 -0400
Date: Wed, 1 Jun 2005 16:10:02 +0200
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: Carsten Otte <cotte@de.ibm.com>
Cc: Arnd Bergmann <arnd@arndb.de>, coywolf@lovecn.org,
       linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
       schwidefsky@de.ibm.com, akpm@osdl.org
Subject: Re: [RFC/PATCH 0/5] add execute in place support
Message-ID: <20050601141002.GA32659@wohnheim.fh-wedel.de>
References: <428216DF.8070205@de.ibm.com> <2cd57c9005060103122b2bae36@mail.gmail.com> <200506011406.04191.arnd@arndb.de> <20050601133938.GB29116@wohnheim.fh-wedel.de> <429DC041.6070001@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <429DC041.6070001@de.ibm.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 1 June 2005 16:03:45 +0200, Carsten Otte wrote:
> Jörn Engel wrote:
> 
> >We can execute the kernel in place, thanks to Nicolas Pitre.  For
> >userspace I have seen to preparation patches, but nothing serious.
  *)
> >
> Given that execute in place describes the ability to run code at
> the very same location where it is permanently stored, and that
> this is exactly what the patch enables, I think the wording is
> correct.

*) except for Carsten's patches.  Sorry about the confusion.

Jörn

-- 
This above all: to thine own self be true.
-- Shakespeare
