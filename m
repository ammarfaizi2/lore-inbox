Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264515AbTLVTT1 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Dec 2003 14:19:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264518AbTLVTT1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Dec 2003 14:19:27 -0500
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:52234 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP id S264515AbTLVTTY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Dec 2003 14:19:24 -0500
To: linux-kernel@vger.kernel.org
Path: gatekeeper.tmr.com!davidsen
From: davidsen@tmr.com (bill davidsen)
Newsgroups: mail.linux-kernel
Subject: Re: iproute2 and 2.6.0 kernel
Date: 22 Dec 2003 19:07:41 GMT
Organization: TMR Associates, Schenectady NY
Message-ID: <bs7fdt$7h0$1@gatekeeper.tmr.com>
References: <20031217114125.GA20057@malvern.uk.w2k.superh.com> <3FE08470.5040801@pacbell.net> <20031218143236.GB20057@malvern.uk.w2k.superh.com> <0d6401c3c576$c6889b00$6e69690a@RIMAS>
X-Trace: gatekeeper.tmr.com 1072120061 7712 192.168.12.62 (22 Dec 2003 19:07:41 GMT)
X-Complaints-To: abuse@tmr.com
Originator: davidsen@gatekeeper.tmr.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <0d6401c3c576$c6889b00$6e69690a@RIMAS>,
Remus <rmocius@auste.elnet.lt> wrote:
| Hi folks,
| 
| I have a linux box with three NICs (two for external ISP, and one local).
| Today I tried to use 2.6.0 kernel and something is wrong, because iproute2
| does not work corretly.
| No routed packets go via second ISP NIC which I use with iproute rules. With
| 2.4.22 kernel I have no problems at all with packet routing.
| 
| I compiled 2.6.0 kernel myself, maybe I missed something in .config file?

Using iproute2 and identifying the packets with the MARK target? I am
seeing that as well, but I wasn't going to post until I had nice configs
in files, packet traces, and the like. So for now take this as a "me too."
-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.
