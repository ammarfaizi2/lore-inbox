Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317995AbSGWIUp>; Tue, 23 Jul 2002 04:20:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317996AbSGWIUp>; Tue, 23 Jul 2002 04:20:45 -0400
Received: from gate.in-addr.de ([212.8.193.158]:38158 "HELO mx.in-addr.de")
	by vger.kernel.org with SMTP id <S317995AbSGWIUo>;
	Tue, 23 Jul 2002 04:20:44 -0400
Date: Tue, 23 Jul 2002 10:16:15 +0200
From: Lars Marowsky-Bree <lmb@suse.de>
To: Larry McVoy <lm@work.bitmover.com>,
       Roger Gammans <roger@computer-surgery.co.uk>,
       linux-kernel@vger.kernel.org
Subject: Re: using bitkeeper to backport subsystems?
Message-ID: <20020723081615.GB1176@marowsky-bree.de>
References: <20020721233410.GA21907@lukas> <20020722071510.GG16559@boardwalk> <20020722102930.A14802@lst.de> <20020722102705.GB21907@lukas> <20020722152031.GB692@opus.bloom.county> <20020722232941.A10083@computer-surgery.co.uk> <20020722154443.E19057@work.bitmover.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20020722154443.E19057@work.bitmover.com>
User-Agent: Mutt/1.4i
X-Ctuhulu: HASTUR
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2002-07-22T15:44:43,
   Larry McVoy <lm@bitmover.com> said:

> > With all due respect to Larry and the bk team, I think you'll
> > find determining 'needed changesets' in this case is a _hard_ problem.
> Thanks, we agree completely.  It's actually an impossible problem
> for a program since it requires semantic knowledge of the content
> under revision control. 

So, another option would be to have the developer define explicit dependencies
for his changesets, but I fear that might prove to cumbersome, too.


Sincerely,
    Lars Marowsky-Brée <lmb@suse.de>

-- 
Immortality is an adequate definition of high availability for me.
	--- Gregory F. Pfister

