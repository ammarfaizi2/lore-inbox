Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264637AbSJ3JgO>; Wed, 30 Oct 2002 04:36:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264639AbSJ3JgO>; Wed, 30 Oct 2002 04:36:14 -0500
Received: from codepoet.org ([166.70.99.138]:37789 "EHLO winder.codepoet.org")
	by vger.kernel.org with ESMTP id <S264637AbSJ3JgO>;
	Wed, 30 Oct 2002 04:36:14 -0500
Date: Wed, 30 Oct 2002 02:42:37 -0700
From: Erik Andersen <andersen@codepoet.org>
To: Miles Bader <miles@gnu.org>
Cc: Jeff Garzik <jgarzik@pobox.com>, Dave Cinege <dcinege@psychosis.com>,
       linux-kernel@vger.kernel.org
Subject: Re: Abbott and Costello meet Crunch Time -- Penultimate 2.5 merge candidate list.
Message-ID: <20021030094236.GB8423@codepoet.org>
Reply-To: andersen@codepoet.org
Mail-Followup-To: Erik Andersen <andersen@codepoet.org>,
	Miles Bader <miles@gnu.org>, Jeff Garzik <jgarzik@pobox.com>,
	Dave Cinege <dcinege@psychosis.com>, linux-kernel@vger.kernel.org
References: <200210272017.56147.landley@trommello.org> <200210300229.44865.dcinege@psychosis.com> <3DBF8CD5.1030306@pobox.com> <200210300322.17933.dcinege@psychosis.com> <20021030085149.GA7919@codepoet.org> <buofzuogv31.fsf@mcspd15.ucom.lsi.nec.co.jp> <3DBFA0F8.9000408@pobox.com> <buobs5cgu7o.fsf@mcspd15.ucom.lsi.nec.co.jp> <3DBFA5C7.1080603@pobox.com> <buo7kg0gtbj.fsf@mcspd15.ucom.lsi.nec.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <buo7kg0gtbj.fsf@mcspd15.ucom.lsi.nec.co.jp>
User-Agent: Mutt/1.3.28i
X-Operating-System: Linux 2.4.19-rmk2, Rebel-NetWinder(Intel StrongARM 110 rev 3), 185.95 BogoMips
X-No-Junk-Mail: I do not want to get *any* junk mail.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed Oct 30, 2002 at 06:38:24PM +0900, Miles Bader wrote:
> Or do you mean have it somehow avoid copying the data areas of the cpio
> stream (i.e. store pointers from the tree-in-ram to the actual data
> blocks in ROM).
> 
> I guess the latter sounds cleaner... it would also have the advantage
> that you could have a tree with the bulk of data in ROM, but which
> allowed new files to be written (which would be stored in RAM).
> 
> Hmmm...sounds very intersting...

Now _that_ would be extremely useful!

 -Erik

--
Erik B. Andersen             http://codepoet-consulting.com/
--This message was written using 73% post-consumer electrons--
