Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261725AbUBVSxS (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Feb 2004 13:53:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261727AbUBVSxS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Feb 2004 13:53:18 -0500
Received: from sinfonix.rz.tu-clausthal.de ([139.174.2.33]:58297 "EHLO
	sinfonix.rz.tu-clausthal.de") by vger.kernel.org with ESMTP
	id S261725AbUBVSxQ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Feb 2004 13:53:16 -0500
From: "Hemmann, Volker Armin" <volker.hemmann@heim9.tu-clausthal.de>
To: oschoett@t-online.de (Oliver Schoett)
Subject: Re: SiS 746FX AGP 3.0 problem
Date: Sun, 22 Feb 2004 19:53:07 +0100
User-Agent: KMail/1.6
Cc: linux-kernel@vger.kernel.org, <Oliver.Heilmann@drkw.com>
References: <200402210044.55107.volker.hemmann@heim10.tu-clausthal.de> <s23znbbq8ik.fsf@oschoett.dialin.t-online.de>
In-Reply-To: <s23znbbq8ik.fsf@oschoett.dialin.t-online.de>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Message-Id: <200402221953.07976.volker.hemmann@heim10.tu-clausthal.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sunday 22 February 2004 19:22, Oliver Schoett wrote:

> Instead of patching the patch, it is perhaps easier for a first test
> to just use the forced timeout shown in the patch below (apply to a
> clean kernel with patch option -p1; patches fine into 2.6.3).  That
> already solved the problems on my machine and showed that my SiS 648
> had the timing problem.

ok, I tried the patch, you sent, and think what happened?
Everything is working fine now, tested two times, since once in a while 
testgart/C worked at the first attempt...
So, it seems you are right, that the 746FX has the same problem like the 
648...

Thanks for your help!
 Now I can boot directly into X again (juhu!).


Glück Auf
Volker
-- 
Conclusions 
 In a straight-up fight, the Empire squashes the Federation like a bug. Even 
with its numerical advantage removed, the Empire would still squash the 
Federation like a bug. Accept it. -Michael Wong 
