Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289000AbSANUNF>; Mon, 14 Jan 2002 15:13:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288959AbSANULh>; Mon, 14 Jan 2002 15:11:37 -0500
Received: from gate.in-addr.de ([212.8.193.158]:41222 "HELO mx.in-addr.de")
	by vger.kernel.org with SMTP id <S289000AbSANUKf>;
	Mon, 14 Jan 2002 15:10:35 -0500
Date: Mon, 14 Jan 2002 21:11:48 +0100
From: Lars Marowsky-Bree <lmb@suse.de>
To: Brian Beattie <alchemy@us.ibm.com>
Cc: James Bottomley <James.Bottomley@SteelEye.com>,
        Mario Mikocevic <mozgy@hinet.hr>, linux-kernel@vger.kernel.org
Subject: Re: FC & MULTIPATH !? (any hope?)
Message-ID: <20020114211148.B935@marowsky-bree.de>
In-Reply-To: <200201141524.g0EFOqj09542@localhost.localdomain> <1011037987.918.0.camel@w-beattie1>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1011037987.918.0.camel@w-beattie1>
User-Agent: Mutt/1.3.22.1i
X-Ctuhulu: HASTUR
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2002-01-14T11:53:07,
   Brian Beattie <alchemy@us.ibm.com> said:

> I've been working with the multipath code.  Trying to add functionality
> to it.  While I have not yet looked at this particular issue, if there
> is interest I would be willing to see what can be done.  I do not think
> it would be a big deal to add the functionality to reactivate a dead
> path.  It should not be too hard to attempt to do so automatically.

It should only be tried on demand, or at least possible to configure it in
this way; more safe.

Sincerely,
    Lars Marowsky-Brée <lmb@suse.de>

-- 
Perfection is our goal, excellence will be tolerated. -- J. Yahl

