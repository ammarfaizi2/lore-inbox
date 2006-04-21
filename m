Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751256AbWDUPq0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751256AbWDUPq0 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Apr 2006 11:46:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751305AbWDUPq0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Apr 2006 11:46:26 -0400
Received: from wohnheim.fh-wedel.de ([213.39.233.138]:25225 "EHLO
	wohnheim.fh-wedel.de") by vger.kernel.org with ESMTP
	id S1751256AbWDUPqZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Apr 2006 11:46:25 -0400
Date: Fri, 21 Apr 2006 17:46:18 +0200
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: Michael Holzheu <HOLZHEU@de.ibm.com>
Cc: linux-kernel@vger.kernel.org, mschwid2@de.ibm.com,
       Pekka Enberg <penberg@cs.helsinki.fi>
Subject: Re: [PATCH/RFC] s390: Hypervisor File System
Message-ID: <20060421154618.GC32710@wohnheim.fh-wedel.de>
References: <20060421151800.GB32710@wohnheim.fh-wedel.de> <OFC950CF81.274302A0-ON42257157.00555085-42257157.0055C641@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <OFC950CF81.274302A0-ON42257157.00555085-42257157.0055C641@de.ibm.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 21 April 2006 17:36:53 +0200, Michael Holzheu wrote:
> 
> That would be ok for us, since we do not have any newlines
> in our strings. I will include this in the next patch!

Thanks!

It would be nice to seperate this patch out from the rest.  It is
useful independently of when and whether hypfs gets merged.

Jörn

-- 
Debugging is twice as hard as writing the code in the first place.
Therefore, if you write the code as cleverly as possible, you are,
by definition, not smart enough to debug it.
-- Brian W. Kernighan
