Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1754239AbWKGSXe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754239AbWKGSXe (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Nov 2006 13:23:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754241AbWKGSXe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Nov 2006 13:23:34 -0500
Received: from mx1.redhat.com ([66.187.233.31]:54252 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1754224AbWKGSXd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Nov 2006 13:23:33 -0500
Subject: Re: [PATCH] make last_inode counter in new_inode 32-bit on kernels
	that offer x86 compatability
From: Jeff Layton <jlayton@redhat.com>
To: =?ISO-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
Cc: Eric Sandeen <sandeen@redhat.com>, linux-fsdevel@vger.kernel.org,
       linux-kernel@vger.kernel.org
In-Reply-To: <20061107181408.GE29746@wohnheim.fh-wedel.de>
References: <1162836725.6952.28.camel@dantu.rdu.redhat.com>
	 <20061106182222.GO27140@parisc-linux.org>
	 <1162838843.12129.8.camel@dantu.rdu.redhat.com>
	 <20061106202313.GA691@wohnheim.fh-wedel.de> <454FA032.1070008@redhat.com>
	 <20061106211134.GB691@wohnheim.fh-wedel.de> <454FAAF8.8080707@redhat.com>
	 <1162914966.28425.24.camel@dantu.rdu.redhat.com>
	 <20061107172835.GB15629@wohnheim.fh-wedel.de>
	 <1162922488.28425.51.camel@dantu.rdu.redhat.com>
	 <20061107181408.GE29746@wohnheim.fh-wedel.de>
Content-Type: text/plain; charset=utf-8
Date: Tue, 07 Nov 2006 13:23:31 -0500
Message-Id: <1162923811.28425.55.camel@dantu.rdu.redhat.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.0 (2.8.0-7.fc6) 
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-11-07 at 19:14 +0100, Jörn Engel wrote:
> Acked-by: Joern Engel <joern@wh.fh-wedel.de>
> 
> Looks good to me.
> 
> Jeff, would you mind taking my patches and putting them into a decent
> patch series?  I really should be working on other things.
> 
> Jörn
> 

Me too, but sure. I'll try to put together a good patch set, and even
test to make sure it builds ;-). I'll probably have something together
by tomorrow sometime.

-- Jeff


