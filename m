Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318076AbSIOQNI>; Sun, 15 Sep 2002 12:13:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318079AbSIOQNI>; Sun, 15 Sep 2002 12:13:08 -0400
Received: from dsl-213-023-039-078.arcor-ip.net ([213.23.39.78]:14465 "EHLO
	starship") by vger.kernel.org with ESMTP id <S318076AbSIOQNH>;
	Sun, 15 Sep 2002 12:13:07 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@arcor.de>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [2.5] DAC960
Date: Sun, 15 Sep 2002 18:20:09 +0200
X-Mailer: KMail [version 1.3.2]
Cc: Jens Axboe <axboe@suse.de>, Samium Gromoff <_deepfire@mail.ru>,
       linux-kernel@vger.kernel.org
References: <E17odbY-000BHv-00@f1.mail.ru> <E17qQum-0001qO-00@starship> <1032102890.25716.7.camel@irongate.swansea.linux.org.uk>
In-Reply-To: <1032102890.25716.7.camel@irongate.swansea.linux.org.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E17qc81-0000D1-00@starship>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 15 September 2002 17:14, Alan Cox wrote:
> On Sun, 2002-09-15 at 05:21, Daniel Phillips wrote:
> > A somewhat curt reply, it could be seen as a brush-off.  I believe the
> > whole story goes something like this: the scsi system is a festering
> > sore on the whole and eventually needs to be rationalized.  But until
> > that happens, we should basically just keep nursing along the various
> > drivers that should be using a generic interface, until there really
> > is a generic interface around worth putting in the effort to port to.
> 
> DAC960 doesn't present a scsi interface to the higher levels. Its
> abstraction truely is block based, like i2o_block, like aacraid, like
> many other cards.

Yup, brainlock, I knew that.  Just bracketing the target...

-- 
Daniel
