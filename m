Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261457AbTIKSa6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Sep 2003 14:30:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261460AbTIKSa6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Sep 2003 14:30:58 -0400
Received: from adsl-63-194-239-202.dsl.lsan03.pacbell.net ([63.194.239.202]:63244
	"EHLO mmp-linux.matchmail.com") by vger.kernel.org with ESMTP
	id S261457AbTIKSa5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Sep 2003 14:30:57 -0400
Date: Thu, 11 Sep 2003 11:30:55 -0700
From: Mike Fedyk <mfedyk@matchmail.com>
To: "Martin J. Bligh" <mbligh@aracnet.com>
Cc: Jens Axboe <axboe@suse.de>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: ide-scsi oops was: 2.6.0-test4-mm3
Message-ID: <20030911183055.GF18399@matchmail.com>
Mail-Followup-To: "Martin J. Bligh" <mbligh@aracnet.com>,
	Jens Axboe <axboe@suse.de>, Andrew Morton <akpm@osdl.org>,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <20030910114346.025fdb59.akpm@osdl.org> <10720000.1063224243@flay> <20030911082057.GP1396@suse.de> <63090000.1063303982@flay>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <63090000.1063303982@flay>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 11, 2003 at 11:13:02AM -0700, Martin J. Bligh wrote:
> >> That's a real shame ... it seemed to work fine until recently. Some
> >> of the DVD writers (eg the one I have - Sony DRU500A or whatever)
> > 
> > Then maybe it would be a really good idea to find out why it doesn't
> > work with ide-cd. What are the symptoms?
> 
> Symptoms are that it required cdrecord-pro, which was a closed source
> piece of turd I can't do much with ;-)

Are you using the version of cdrecord with Linus' patch when he added CDR capability to
ide-cd?

I know it has been in debian testing for a while now...
