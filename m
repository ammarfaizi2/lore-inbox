Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263284AbTCUG1f>; Fri, 21 Mar 2003 01:27:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263285AbTCUG1e>; Fri, 21 Mar 2003 01:27:34 -0500
Received: from twilight.cs.hut.fi ([130.233.40.5]:22374 "EHLO
	twilight.cs.hut.fi") by vger.kernel.org with ESMTP
	id <S263284AbTCUG1e>; Fri, 21 Mar 2003 01:27:34 -0500
Date: Fri, 21 Mar 2003 08:38:22 +0200
From: Ville Herva <vherva@niksula.hut.fi>
To: Hank Leininger <hlein@progressive-comp.com>,
       =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>,
       linux-kernel@vger.kernel.org
Subject: Re: Deprecating .gz format on kernel.org
Message-ID: <20030321063822.GK159052@niksula.cs.hut.fi>
Mail-Followup-To: Ville Herva <vherva@niksula.cs.hut.fi>,
	Hank Leininger <hlein@progressive-comp.com>,
	=?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>,
	linux-kernel@vger.kernel.org
References: <20030320221332.GA13641@wohnheim.fh-wedel.de> <010303201736060.23184-100000@timmy.spinoli.org> <20030321062635.GJ159052@niksula.cs.hut.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030321062635.GJ159052@niksula.cs.hut.fi>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 21, 2003 at 08:26:35AM +0200, you [Ville Herva] wrote:
> 
> bzip2 -d < foo.tar.bz2 | tee >(md5sum) | tar xf
> or
> bzip2 -d < foo.tar.bz2 | tee >(gpg --verify foo.tar.bz2.sig) | tar xf

Uhh sorry, "tar x" or "tar xf -" (if your tar so requires, most don't), not
"tar xf". Not enough coffee...


-- v --

v@iki.fi
