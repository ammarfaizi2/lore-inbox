Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264389AbTFPWgq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Jun 2003 18:36:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264393AbTFPWgq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Jun 2003 18:36:46 -0400
Received: from 198.216-123-194-0.interbaun.com ([216.123.194.198]:44478 "EHLO
	mail.harddata.com") by vger.kernel.org with ESMTP id S264389AbTFPWgo
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Jun 2003 18:36:44 -0400
Date: Mon, 16 Jun 2003 16:50:28 -0600
From: Michal Jaegermann <michal@harddata.com>
To: linux-kernel@vger.kernel.org
Subject: [x86_64] soft power-off question
Message-ID: <20030616165028.A3222@mail.harddata.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Is it possible to turn off power on a dual processor x86_64 board with
'halt -p' or similar?  If yes then what is needed on a kernel level?
I know that this does not work with "distribution" kernels.
What about single processor boards (although I did not see yet
one of x86_64 kind :-)?

  Michal
