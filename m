Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265656AbUAGWeZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jan 2004 17:34:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265661AbUAGWeZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jan 2004 17:34:25 -0500
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:29964 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP id S265656AbUAGWeY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jan 2004 17:34:24 -0500
To: linux-kernel@vger.kernel.org
Path: gatekeeper.tmr.com!davidsen
From: davidsen@tmr.com (bill davidsen)
Newsgroups: mail.linux-kernel
Subject: Re: The survival of ide-scsi in 2.6.x
Date: 7 Jan 2004 22:22:20 GMT
Organization: TMR Associates, Schenectady NY
Message-ID: <bti0qs$7dc$1@gatekeeper.tmr.com>
References: <200401052200.i05M0vnm002436@harpo.it.uu.se>
X-Trace: gatekeeper.tmr.com 1073514140 7596 192.168.12.62 (7 Jan 2004 22:22:20 GMT)
X-Complaints-To: abuse@tmr.com
Originator: davidsen@gatekeeper.tmr.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <200401052200.i05M0vnm002436@harpo.it.uu.se>,
Mikael Pettersson  <mikpe@csd.uu.se> wrote:
| On Fri, 26 Dec 2003 13:12:42 -0500, Willem Riede wrote:
| >I know that many feel that ide-scsi is useless, and should go away.
| >And you are probably tired of message threads talking about it.
| >Yet I ask respectfully that you hear me out, and give me feedback.
| >
| >I need ide-scsi to survive. Why? I maintain osst, a driver for
| >OnStream tape drives, which need special handling. These drives
| ...
| >So can we agree to keep ide-scsi? I know it is not desired any
| >more for cd writers. To avoid the problem reports from people who
| >don't realize that and select ide-scsi anyway, we can refuse to
| >attach to a cd-type device (today it just warns). And/or make a 
| >new explicit module parameter to tell ide-scsi exactly which 
| >drives to attach to.
| 
| I have a simple patch to do exactly that. Contact me if you want it.

I interpret a recent note to say that Willem Riede is provisional
maintainer, so please send him what you have. It would be great to get
some of the personal fixes into the code base.
-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.
