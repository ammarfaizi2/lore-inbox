Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751318AbWIKJb4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751318AbWIKJb4 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Sep 2006 05:31:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751320AbWIKJb4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Sep 2006 05:31:56 -0400
Received: from mail.math.TU-Berlin.DE ([130.149.12.212]:49071 "EHLO
	mail.math.TU-Berlin.DE") by vger.kernel.org with ESMTP
	id S1751318AbWIKJbz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Sep 2006 05:31:55 -0400
From: Thomas Richter <thor@mail.math.tu-berlin.de>
Message-Id: <200609110927.k8B9RJfH019016@mersenne.math.TU-Berlin.DE>
Subject: Sensors on Asus M2N SLI Deluxe
To: linux-kernel@vger.kernel.org
Date: Mon, 11 Sep 2006 11:27:19 +0200 (CEST)
X-Mailer: ELM [version 2.4ME+ PL108 (25)]
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi folks,

aparently the 2.6.17.8 kernel or rather the lm_sensors package which is
part of this kernel does not recognize the on-board chips of this 
motherboard correctly. sensors-detect seems to find some chips, but
likely not the correct one as it seems. The corresponding entry in /proc
remains empty, though.

Is there any plan/idea how to support this motherboard?
Is there something I could provide/test to get it supported?

Thanks,
	Thomas



