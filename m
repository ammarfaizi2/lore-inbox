Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288952AbSAISNG>; Wed, 9 Jan 2002 13:13:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288954AbSAISM5>; Wed, 9 Jan 2002 13:12:57 -0500
Received: from e34.co.us.ibm.com ([32.97.110.132]:33930 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S288952AbSAISMq>; Wed, 9 Jan 2002 13:12:46 -0500
From: Badari Pulavarty <pbadari@us.ibm.com>
Message-Id: <200201091812.g09ICBF18477@eng2.beaverton.ibm.com>
Subject: Re: [PATCH] PAGE_SIZE IO for RAW (RAW VARY)
To: bcrl@redhat.com (Benjamin LaHaise)
Date: Wed, 9 Jan 2002 10:12:11 -0800 (PST)
Cc: pbadari@us.ibm.com (Badari Pulavarty), linux-kernel@vger.kernel.org,
        marcelo@conectiva.com.br, andrea@suse.de
In-Reply-To: <20020109125845.B12609@redhat.com> from "Benjamin LaHaise" at Jan 09, 2002 11:58:45 AM PST
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 
> On Wed, Jan 09, 2002 at 09:41:10AM -0800, Badari Pulavarty wrote:
> > Could you please consider this for 2.4.18 release ? If you need the
> > patch on 2.4.18-preX, I can make one quickly.
> 
> Do not apply.  This breaks the majority of databases that run under linux.
> 
> 		-ben
> 

why ? could you explain ? I am not expecting that user buffer be aligned
to PAGE_SIZE.

Thanks,
Badari
