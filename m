Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317189AbSIAPtm>; Sun, 1 Sep 2002 11:49:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317215AbSIAPtm>; Sun, 1 Sep 2002 11:49:42 -0400
Received: from dsl-213-023-020-041.arcor-ip.net ([213.23.20.41]:2689 "EHLO
	starship") by vger.kernel.org with ESMTP id <S317189AbSIAPtl>;
	Sun, 1 Sep 2002 11:49:41 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@arcor.de>
To: Chris Wright <chris@wirex.com>,
       Ingo Oeser <ingo.oeser@informatik.tu-chemnitz.de>
Subject: Re: extended file permissions based on LSM
Date: Sun, 1 Sep 2002 17:55:39 +0200
X-Mailer: KMail [version 1.3.2]
Cc: Greg KH <greg@kroah.com>, Gabor Kerenyi <wom@tateyama.hu>,
       linux-kernel@vger.kernel.org, Chris Wright <chris@wirex.com>
References: <200208310616.04709.wom@tateyama.hu> <20020831095747.A781@nightmaster.csn.tu-chemnitz.de> <20020831172656.E11165@figure1.int.wirex.com>
In-Reply-To: <20020831172656.E11165@figure1.int.wirex.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E17lX4d-0004a1-00@starship>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 01 September 2002 02:26, Chris Wright wrote:
> * Ingo Oeser (ingo.oeser@informatik.tu-chemnitz.de) wrote:
> > 
> > So this is a correctly pointed out design weakness: The way the
> > user took to reach the inode cannot be taken into account.
> 
> Yes, this is known, and there are anticipated VFS changes to remedy
> this.

Could you describe them, please?

-- 
Daniel
