Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288951AbSAISOg>; Wed, 9 Jan 2002 13:14:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288956AbSAISOW>; Wed, 9 Jan 2002 13:14:22 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:26632 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S288954AbSAISNp>;
	Wed, 9 Jan 2002 13:13:45 -0500
Date: Wed, 9 Jan 2002 19:13:34 +0100
From: Jens Axboe <axboe@suse.de>
To: Benjamin LaHaise <bcrl@redhat.com>
Cc: Badari Pulavarty <pbadari@us.ibm.com>, linux-kernel@vger.kernel.org,
        marcelo@conectiva.com.br, andrea@suse.de
Subject: Re: [PATCH] PAGE_SIZE IO for RAW (RAW VARY)
Message-ID: <20020109191334.K19814@suse.de>
In-Reply-To: <200201091741.g09HfAI17240@eng2.beaverton.ibm.com> <20020109125845.B12609@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020109125845.B12609@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 09 2002, Benjamin LaHaise wrote:
> On Wed, Jan 09, 2002 at 09:41:10AM -0800, Badari Pulavarty wrote:
> > Could you please consider this for 2.4.18 release ? If you need the
> > patch on 2.4.18-preX, I can make one quickly.
> 
> Do not apply.  This breaks the majority of databases that run under linux.

Besides, it's much more of a 'lets just clamp this on' approach than a
real solution.

-- 
Jens Axboe

