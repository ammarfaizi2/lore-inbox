Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279934AbRKDWzR>; Sun, 4 Nov 2001 17:55:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279858AbRKDWy6>; Sun, 4 Nov 2001 17:54:58 -0500
Received: from borderworlds.dk ([193.162.142.101]:38927 "HELO
	klingon.borderworlds.dk") by vger.kernel.org with SMTP
	id <S279811AbRKDWyw>; Sun, 4 Nov 2001 17:54:52 -0500
To: Daniel Phillips <phillips@bonn-fries.net>
Cc: linux-kernel@vger.kernel.org, Andreas Dilger <adilger@turbolabs.com>
Subject: Re: Ext2 directory index, updated
In-Reply-To: <20011104022659Z16995-4784+750@humbolt.nl.linux.org>
	<m3hesatcgq.fsf@borg.borderworlds.dk>
	<20011104222259Z17054-18972+2@humbolt.nl.linux.org>
From: Christian Laursen <xi@borderworlds.dk>
Date: 04 Nov 2001 23:54:50 +0100
In-Reply-To: <20011104222259Z17054-18972+2@humbolt.nl.linux.org>
Message-ID: <m3bsiitadh.fsf@borg.borderworlds.dk>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Daniel Phillips <phillips@bonn-fries.net> writes:

> There is an easy way to turn that FEATURE_COMPAT flag back off so you can 
> fsck, but I don't know it and I should.

I figured it out by myself. :)

$ debugfs -w root_fs
debugfs:  feature -dir_index

-- 
Best regards
    Christian Laursen
