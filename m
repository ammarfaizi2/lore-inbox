Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262550AbTI1NCl (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 Sep 2003 09:02:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262551AbTI1NCl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 Sep 2003 09:02:41 -0400
Received: from fep02.swip.net ([130.244.199.130]:63157 "EHLO
	fep02-svc.swip.net") by vger.kernel.org with ESMTP id S262550AbTI1NCk
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 Sep 2003 09:02:40 -0400
From: "Michal Semler (volny.cz)" <cijoml@volny.cz>
Reply-To: cijoml@volny.cz
To: linux-kernel@vger.kernel.org
Subject: 3C59x module doesn't work in 2.6.0-test6
Date: Sun, 28 Sep 2003 15:02:38 +0200
User-Agent: KMail/1.5.4
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200309281502.38370.cijoml@volny.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I compiled 2.6.0-test6, but my ethernet card doesn't work:

modprobe 3c59x tells this:
Sep 28 10:06:58 tata kernel: 3c59x: Unknown parameter `3c509x'

Michal

