Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264893AbUD2RMp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264893AbUD2RMp (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Apr 2004 13:12:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264896AbUD2RMp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Apr 2004 13:12:45 -0400
Received: from c3p0.cc.swin.edu.au ([136.186.1.30]:15880 "EHLO swin.edu.au")
	by vger.kernel.org with ESMTP id S264893AbUD2RMn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Apr 2004 13:12:43 -0400
To: Neal Becker <ndbecker2@verizon.net>
Cc: linux-kernel@vger.kernel.org
From: Tim Connors <tconnors+linuxkernel1083258663@astro.swin.edu.au>
Subject: Re:  State of linux checkpointing?
In-reply-to: <40912DD2.90900@lbl.gov>
References: <c6oorn$3dq$1@sea.gmane.org> <409012A4.9000502@pobox.com> <slrn-0.9.7.4-11992-4650-200404290913-tc@hexane.ssi.swin.edu.au> <c6plh7$sqj$1@sea.gmane.org> <40912DD2.90900@lbl.gov>
X-Face: m+g#A-,3D0}Ygy5KUD`Hckr=I9Au;w${NzE;Iz!6bOPqeX^]}KGt=l~r!8X|W~qv'`Ph4dZczj*obWD25|2+/a5.$#s23k"0$ekRhi,{cP,CUk=}qJ/I1acc
Message-ID: <slrn-0.9.7.4-18380-21584-200404300311-tc@hexane.ssi.swin.edu.au>
Date: Fri, 30 Apr 2004 03:12:08 +1000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thomas Davis <tadavis@lbl.gov> said on Thu, 29 Apr 2004 09:31:14 -0700:
> Neal Becker wrote:
> > 
> > I want checkpointing for:
> > 
> > 1) Protect against job interruption due to system crash, operator error,
> > power loss, whatever
> > 
> > 2) Job mygration.  Even manual job mygration would be nice.
> 
> Two possible solutions:
> 
> 1) http://ftg.lbl.gov/checkpoint

Oooh. Shiny.

That looks relatively new? I haven't come across it before...

-- 
TimC -- http://astronomy.swin.edu.au/staff/tconnors/
Yesterday, after years of trying, I finally managed to take a photo of a
subway train that said "INSTRUCTION CAR" just so that someday I can caption
it "...but where's the DATA CDR?" when I'm ready to make a joke that's
nerdy even by the standards of jokes about LISP.    -- James "Kibo" Perry
