Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261268AbRE3PLY>; Wed, 30 May 2001 11:11:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261296AbRE3PLO>; Wed, 30 May 2001 11:11:14 -0400
Received: from mailgate.rz.uni-karlsruhe.de ([129.13.64.97]:56590 "EHLO
	mailgate.rz.uni-karlsruhe.de") by vger.kernel.org with ESMTP
	id <S261268AbRE3PLI>; Wed, 30 May 2001 11:11:08 -0400
To: anuradha@gnu.org
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] compiler warning fix in aci.c
From: Robert Siemer <Robert.Siemer@gmx.de>
In-Reply-To: <Pine.LNX.4.21.0105301718480.22876-100000@presario>
In-Reply-To: <20010530113700W.siemer@panorama.hadiko.de>
	<Pine.LNX.4.21.0105301718480.22876-100000@presario>
X-Mailer: Mew version 1.94b25 on Emacs 20.5 / Mule 4.0 (HANANOEN)
Reply-To: Robert Siemer <siemer@panorama.hadiko.de>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <20010530171052Z.siemer@panorama.hadiko.de>
Date: Wed, 30 May 2001 17:10:52 +0200
X-Dispatcher: imput version 990425(IM115)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Anuradha Ratnaweera <anuradha@gnu.org>
> On Wed, 30 May 2001, Robert Siemer wrote:

> > > > Following patch fixes a compiler warning in aci.c.

> > > ... how about putting it inside an "#ifdef DEBUG"?
> > 
> > This is exactly what I did some month ago with my little working
> > tree.
> 
> So will you be adding the "#ifdef" again?

My next kernel patch for the aci will do so, or I'll remove some
debugging code. - In any case I'll pay more attention to compiler
warnings.

As I'm currently short of time it will take some weeks...
(The next patch will also include more RDS/RBDS code for the miroSOUND
PCM20 radio)

Bye,
	Robert
