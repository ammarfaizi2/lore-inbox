Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265285AbTIJUPU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Sep 2003 16:15:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265323AbTIJUPU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Sep 2003 16:15:20 -0400
Received: from e5.ny.us.ibm.com ([32.97.182.105]:52193 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S265285AbTIJUPQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Sep 2003 16:15:16 -0400
Date: Wed, 10 Sep 2003 13:04:03 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Andrew Morton <akpm@osdl.org>, Mike Fedyk <mfedyk@matchmail.com>
cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: ide-scsi oops was: 2.6.0-test4-mm3
Message-ID: <10720000.1063224243@flay>
In-Reply-To: <20030910114346.025fdb59.akpm@osdl.org>
References: <20030828235649.61074690.akpm@osdl.org><20030910185338.GA1461@matchmail.com><20030910185537.GB1461@matchmail.com> <20030910114346.025fdb59.akpm@osdl.org>
X-Mailer: Mulberry/2.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> I have another oops for you with 2.6.0-test4-mm3-1 and ide-scsi. 
> 
> ide-scsi is a dead duck.  defunct.  kaput.  Don't use it.  It's only being
> kept around for weirdo things like IDE-based tape drives, scanners, etc.
> 
> Just use /dev/hdX directly.

That's a real shame ... it seemed to work fine until recently. Some
of the DVD writers (eg the one I have - Sony DRU500A or whatever)
need it. Is it unfixable? or just nobody's done it?

M.

