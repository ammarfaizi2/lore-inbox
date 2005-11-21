Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932356AbVKUQUg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932356AbVKUQUg (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Nov 2005 11:20:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932369AbVKUQUf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Nov 2005 11:20:35 -0500
Received: from courier.cs.helsinki.fi ([128.214.9.1]:20869 "EHLO
	mail.cs.helsinki.fi") by vger.kernel.org with ESMTP id S932356AbVKUQUe
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Nov 2005 11:20:34 -0500
Subject: Re: [PATCH 6/12: eCryptfs] Superblock operations
From: Pekka Enberg <penberg@cs.helsinki.fi>
To: Michael Thompson <michael.craig.thompson@gmail.com>
Cc: Phillip Hellewell <phillip@hellewell.homeip.net>, akpm@osdl.org,
       linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
       viro@ftp.linux.org.uk, mike@halcrow.us, mhalcrow@us.ibm.com,
       mcthomps@us.ibm.com, yoder1@us.ibm.com
In-Reply-To: <afcef88a0511210815o160f4a8k772d2cf3954c6602@mail.gmail.com>
References: <20051119041130.GA15559@sshock.rn.byu.edu>
	 <20051119041910.GF15747@sshock.rn.byu.edu>
	 <84144f020511190250x2efdbfb4vf33245b3f7216fe5@mail.gmail.com>
	 <afcef88a0511210757y4fdb8c57w221b0fc9e7ee3ee4@mail.gmail.com>
	 <1132588916.8487.3.camel@localhost>
	 <afcef88a0511210813i5a5f4382k1b5e876fbbb9a931@mail.gmail.com>
	 <afcef88a0511210815o160f4a8k772d2cf3954c6602@mail.gmail.com>
Date: Mon, 21 Nov 2005 18:20:32 +0200
Message-Id: <1132590032.8487.9.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution 2.4.1 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Michael,

On 11/21/05, Pekka Enberg <penberg@cs.helsinki.fi> wrote:
> > > You can set ecryptfs_sops->drop_inode to generic_delete_inode directly,
> > > no?

On Mon, 2005-11-21 at 09:57 -0600, Michael Thompson wrote:
> > Yes, I do believe I could do that and save a function call. My mind is
> > wobbely today.
> 
> Very wobbley, can't even spell right. Is this an acceptable solution?
> I didn't even bother to ask that ;)

Yes, that's what I was suggesting.

			Pekka

