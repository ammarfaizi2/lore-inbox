Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265777AbUAHSvM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jan 2004 13:51:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265788AbUAHSvM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jan 2004 13:51:12 -0500
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:59406 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP id S265777AbUAHSvJ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Jan 2004 13:51:09 -0500
To: linux-kernel@vger.kernel.org
Path: gatekeeper.tmr.com!davidsen
From: davidsen@tmr.com (bill davidsen)
Newsgroups: mail.linux-kernel
Subject: Re: 2.6.0 and hyperthreading
Date: 8 Jan 2004 18:39:03 GMT
Organization: TMR Associates, Schenectady NY
Message-ID: <btk847$dn1$1@gatekeeper.tmr.com>
References: <20031229214508.GG916@mail.muni.cz>
X-Trace: gatekeeper.tmr.com 1073587143 14049 192.168.12.62 (8 Jan 2004 18:39:03 GMT)
X-Complaints-To: abuse@tmr.com
Originator: davidsen@gatekeeper.tmr.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <20031229214508.GG916@mail.muni.cz>,
Lukas Hejtmanek  <xhejtman@hell.sks3.muni.cz> wrote:
| Hello,
| 
| is it possible to use Hyperthreading on the processor that supports
| hypperthreading but motherboard has no idea about SMP?

Does the motherboard support hyperthreading? Is there a BIOS option to
enable it? If not, the pin to do so is probably not enabled (as I
remember how that works).
-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.
