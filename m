Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129184AbRBUQkz>; Wed, 21 Feb 2001 11:40:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129104AbRBUQkq>; Wed, 21 Feb 2001 11:40:46 -0500
Received: from hermes.mixx.net ([212.84.196.2]:29958 "HELO hermes.mixx.net")
	by vger.kernel.org with SMTP id <S129051AbRBUQkc>;
	Wed, 21 Feb 2001 11:40:32 -0500
From: Daniel Phillips <phillips@innominate.de>
To: Bernd Eckenfels <W1012@lina.inka.de>, linux-kernel@vger.kernel.org
Subject: Re: [rfc] Near-constant time directory index for Ext2
Date: Wed, 21 Feb 2001 17:38:40 +0100
X-Mailer: KMail [version 1.0.28]
Content-Type: text/plain; charset=US-ASCII
In-Reply-To: <E14VNhp-0000Bf-00@sites.inka.de>
In-Reply-To: <E14VNhp-0000Bf-00@sites.inka.de>
MIME-Version: 1.0
Message-Id: <0102211739300C.18944@gimli>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 21 Feb 2001, Bernd Eckenfels wrote:
> In article <01022100361408.18944@gimli> you wrote:
> > But actually, rm is not problem, it's open and create.  To do a
> > create you have to make sure the file doesn't already exist, and
> > without an index you have to scan on average half the directory file. 
> 
> Unless you use a File System which is better for that, like Reiser-FS. Of
> course a even better solution is to distribute those files in hashed subdirs.

Ahem.  Please read the first post in the thread. ;-)

-- 
Daniel
