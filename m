Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261900AbTCEBXT>; Tue, 4 Mar 2003 20:23:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266865AbTCEBXT>; Tue, 4 Mar 2003 20:23:19 -0500
Received: from mx12.arcor-online.net ([151.189.8.88]:145 "EHLO
	mx12.arcor-online.net") by vger.kernel.org with ESMTP
	id <S261900AbTCEBXS>; Tue, 4 Mar 2003 20:23:18 -0500
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@arcor.de>
To: "James H. Cloos Jr." <cloos@jhcloos.com>, ext2-devel@lists.sf.net
Subject: Re: ext3 htree brelse problems look to be fixed!
Date: Wed, 5 Mar 2003 09:24:52 +0100
X-Mailer: KMail [version 1.3.2]
Cc: ext3-users@redhat.com, linux-kernel@vger.kernel.org
References: <m3of4q4rdl.fsf@lugabout.jhcloos.org>
In-Reply-To: <m3of4q4rdl.fsf@lugabout.jhcloos.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20030305013347.F0C9CECEC3@mx12.arcor-online.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 05 Mar 03 00:57, James H. Cloos Jr. wrote:
> I beleive (with this patch) htree is now ready for prime time.

Good that it's working for you, but it's not quite the last issue.  There is 
some apparent cache thrashing to track down, and I believe there's still an 
outstanding NFS issue.  It's getting there, though.

Regards,

Daniel
