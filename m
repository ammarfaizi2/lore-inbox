Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287939AbSAHGI6>; Tue, 8 Jan 2002 01:08:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287940AbSAHGIs>; Tue, 8 Jan 2002 01:08:48 -0500
Received: from lacrosse.corp.redhat.com ([12.107.208.154]:32671 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id <S287939AbSAHGIh>; Tue, 8 Jan 2002 01:08:37 -0500
Date: Tue, 8 Jan 2002 01:08:36 -0500
From: Benjamin LaHaise <bcrl@redhat.com>
To: Keith Owens <kaos@ocs.com.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [orphan patch] 2.5.2-pre9 Assign syscall numbers for testing
Message-ID: <20020108010836.A8757@redhat.com>
In-Reply-To: <20020108005125.D7376@redhat.com> <5319.1010469696@kao2.melbourne.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <5319.1010469696@kao2.melbourne.sgi.com>; from kaos@ocs.com.au on Tue, Jan 08, 2002 at 05:01:36PM +1100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 08, 2002 at 05:01:36PM +1100, Keith Owens wrote:
> On Tue, 8 Jan 2002 00:51:25 -0500, 
> Benjamin LaHaise <bcrl@redhat.com> wrote:
> >On Tue, Jan 08, 2002 at 01:50:21PM +1100, Keith Owens wrote:
> >> I have sent this patch to Linus twice and got no reply.  I don't have
> >> time to maintain it, this is now an orphan patch.  If anybody wants it,
> >> they can have it.
> >
> >Do NOT apply this patch, it breaks forward compatibility assumptions.
> 
> Read the patch.

It's still a vomituously gross numbers only thing that will cause nothing 
but problems.

		-ben
-- 
Fish.
