Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262232AbTIMXG7 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 Sep 2003 19:06:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262237AbTIMXG7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 Sep 2003 19:06:59 -0400
Received: from smtp.slac.stanford.edu ([134.79.18.80]:26825 "EHLO
	smtp.slac.stanford.edu") by vger.kernel.org with ESMTP
	id S262232AbTIMXG6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 Sep 2003 19:06:58 -0400
Date: Sat, 13 Sep 2003 16:06:56 -0700
From: Philip Clark <pclark@SLAC.Stanford.EDU>
Subject: PCMCIA in 2.6.0-test5
To: linux-kernel@vger.kernel.org
Message-id: <x34y8ws47an.fsf@bbrcu5.slac.stanford.edu>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7BIT
User-Agent: Gnus/5.1002 (Gnus v5.10.2) Emacs/21.2 (gnu/linux)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Does anyone know of problems with pcmcia in test5? When I moved from
test4 -> test5 there are now problems and I get "no sockets found"
messages when I try to start pcmcia. If I do lspci then it detects the
cardbus bridge no problem. Is anyone out there having similar problems? 

Cheers

-Phil
