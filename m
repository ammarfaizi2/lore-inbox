Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288948AbSAIR7G>; Wed, 9 Jan 2002 12:59:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288946AbSAIR64>; Wed, 9 Jan 2002 12:58:56 -0500
Received: from lacrosse.corp.redhat.com ([12.107.208.154]:11684 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id <S288940AbSAIR6x>; Wed, 9 Jan 2002 12:58:53 -0500
Date: Wed, 9 Jan 2002 12:58:45 -0500
From: Benjamin LaHaise <bcrl@redhat.com>
To: Badari Pulavarty <pbadari@us.ibm.com>
Cc: linux-kernel@vger.kernel.org, marcelo@conectiva.com.br, andrea@suse.de
Subject: Re: [PATCH] PAGE_SIZE IO for RAW (RAW VARY)
Message-ID: <20020109125845.B12609@redhat.com>
In-Reply-To: <200201091741.g09HfAI17240@eng2.beaverton.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <200201091741.g09HfAI17240@eng2.beaverton.ibm.com>; from pbadari@us.ibm.com on Wed, Jan 09, 2002 at 09:41:10AM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 09, 2002 at 09:41:10AM -0800, Badari Pulavarty wrote:
> Could you please consider this for 2.4.18 release ? If you need the
> patch on 2.4.18-preX, I can make one quickly.

Do not apply.  This breaks the majority of databases that run under linux.

		-ben
