Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261298AbSJYHce>; Fri, 25 Oct 2002 03:32:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261300AbSJYHce>; Fri, 25 Oct 2002 03:32:34 -0400
Received: from TYO201.gate.nec.co.jp ([210.143.35.51]:26557 "EHLO
	TYO201.gate.nec.co.jp") by vger.kernel.org with ESMTP
	id <S261298AbSJYHcd>; Fri, 25 Oct 2002 03:32:33 -0400
To: Peter Braam <braam@clusterfs.com>
Cc: viro@math.psu.edu, linux-fsdevel@vger.kernel.org,
       linux-kernel@vger.kernel.org, lustre-devel@lists.sf.net
Subject: Re: [PATCH/RFC] 2.5 vfs intent lookup patch
References: <20021025063249.GA1359@localhost.localdomain>
Reply-To: Miles Bader <miles@gnu.org>
System-Type: i686-pc-linux-gnu
Blat: Foop
From: Miles Bader <miles@lsi.nec.co.jp>
Date: 25 Oct 2002 16:38:38 +0900
In-Reply-To: <20021025063249.GA1359@localhost.localdomain>
Message-ID: <buohefbge81.fsf@mcspd15.ucom.lsi.nec.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Peter Braam <braam@clusterfs.com> writes:
> Attached is a 2.5 patch for lookup intents, which we use with Lustre.
> This patch adds a lookup2, revalidate2 and intent_release method.
> 
> Do you have a good idea how to do this better?

At least use better names than `lookup2' &c.

[`lookup_with_intent'?]

-Miles
-- 
Somebody has to do something, and it's just incredibly pathetic that it
has to be us.  -- Jerry Garcia
