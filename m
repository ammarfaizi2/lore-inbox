Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965208AbWECO6E@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965208AbWECO6E (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 May 2006 10:58:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965211AbWECO6E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 May 2006 10:58:04 -0400
Received: from mtagate4.de.ibm.com ([195.212.29.153]:54763 "EHLO
	mtagate4.de.ibm.com") by vger.kernel.org with ESMTP id S965208AbWECO6D
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 May 2006 10:58:03 -0400
Subject: Re: [PATCH] s390: Hypervisor File System
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Reply-To: schwidefsky@de.ibm.com
To: Michael Holzheu <HOLZHEU@de.ibm.com>
Cc: mschwid2@de.ibm.com, akpm@osdl.org, Greg KH <greg@kroah.com>,
       ioe-lkml@rameria.de,
       =?ISO-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>,
       linux-kernel@vger.kernel.org, Kyle Moffett <mrmacman_g4@mac.com>,
       Pekka J Enberg <penberg@cs.Helsinki.FI>
In-Reply-To: <OF5E632A7B.34B50D9A-ON42257163.004ED910-42257163.004F1570@de.ibm.com>
References: <OF5E632A7B.34B50D9A-ON42257163.004ED910-42257163.004F1570@de.ibm.com>
Content-Type: text/plain
Organization: IBM Corporation
Date: Wed, 03 May 2006 16:58:06 +0200
Message-Id: <1146668286.2661.23.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-05-03 at 16:23 +0200, Michael Holzheu wrote:
> mschwid2@de.ltcfwd.linux.ibm.com wrote on 05/03/2006 04:17:40 PM:
> > And the user space then uses the parser only? Is now the parser
> > interface the "ABI" or the kernel interface that is in turn used by the
> > parser? And what happens if somebody comes up with a "better" parser
> > that does things subtly different?
> 
> The ABI is not defined by the Parser. You have to specify the
> tag language, which is part of the ABI. Any parser, which is comliant
> to the specification of the tag language can be used.

Optimist.

-- 
blue skies,
  Martin.

Martin Schwidefsky
Linux for zSeries Development & Services
IBM Deutschland Entwicklung GmbH

"Reality continues to ruin my life." - Calvin.


