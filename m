Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280996AbRKGViO>; Wed, 7 Nov 2001 16:38:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280991AbRKGVh5>; Wed, 7 Nov 2001 16:37:57 -0500
Received: from twilight.cs.hut.fi ([130.233.40.5]:48185 "EHLO
	twilight.cs.hut.fi") by vger.kernel.org with ESMTP
	id <S280996AbRKGVhm>; Wed, 7 Nov 2001 16:37:42 -0500
Date: Wed, 7 Nov 2001 23:37:31 +0200
From: Ville Herva <vherva@niksula.hut.fi>
To: linux-kernel@vger.kernel.org
Subject: Re: ext3 vs resizerfs vs xfs
Message-ID: <20011107233731.N1504@niksula.cs.hut.fi>
In-Reply-To: <E161UYR-0004S5-00@the-village.bc.nu> <E161Vbf-0000m9-00@lilac.csi.cam.ac.uk> <20011107213837.F26218@niksula.cs.hut.fi> <E161ZYW-0006ky-00@mauve.csi.cam.ac.uk> <20011107141157.L5922@lynx.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20011107141157.L5922@lynx.no>; from adilger@turbolabs.com on Wed, Nov 07, 2001 at 02:11:57PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 07, 2001 at 02:11:57PM -0700, [Andreas Dilger] said:
> 
> If you have an open but unlinked file, then ext3 will delete this file at
> mount/fsck time (unlike reiserfs which leaves it around wasting space).

Is this really still true for reiserfs? Is there a way to get rid of them?
reiserfsck? I had this vague impression that this bug had been dealt with
but...


-- v --

v@iki.fi
