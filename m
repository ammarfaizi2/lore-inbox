Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262788AbTLSMzv (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Dec 2003 07:55:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263497AbTLSMyb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Dec 2003 07:54:31 -0500
Received: from mail.linuxtv.org ([212.84.236.4]:27578 "EHLO
	mail.convergence.de") by vger.kernel.org with ESMTP id S262788AbTLSM2k convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Dec 2003 07:28:40 -0500
Subject: [PATCH 1/12] Remove firmware of av7110 driver
In-Reply-To: <10718369183635@convergence.de>
X-Mailer: gregkh_patchbomb_levon_offspring
Date: Fri, 19 Dec 2003 13:28:39 +0100
Message-Id: <10718369193344@convergence.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: akpm@osdl.org, torvalds@osdl.org, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Michael Hunold <hunold@linuxtv.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

... sent to Linus and Andrew in private only. 
It removes the firmware for the dvb-ttpci / av7110 driver, you can
do "rm drivers/media/dvb/ttpci/av7110_firm.h" as well.

