Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261364AbTHZPsW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Aug 2003 11:48:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262540AbTHZPsW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Aug 2003 11:48:22 -0400
Received: from fep03.swip.net ([130.244.199.131]:30350 "EHLO
	fep03-svc.swip.net") by vger.kernel.org with ESMTP id S261364AbTHZPsS
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Aug 2003 11:48:18 -0400
From: "Michal Semler (volny.cz)" <cijoml@volny.cz>
Reply-To: cijoml@volny.cz
To: linux-kernel@vger.kernel.org
Subject: 2.6.0-test4 and /etc/modules.conf
Date: Tue, 26 Aug 2003 17:48:19 +0200
User-Agent: KMail/1.5.3
References: <200308252332.46101.cijoml@volny.cz> <200308261428.07929.cijoml@volny.cz> <20030826123312.GD7038@fs.tum.de>
In-Reply-To: <20030826123312.GD7038@fs.tum.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200308261748.20002.cijoml@volny.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I have in /etc/modules.conf defined which modules to use. 2.4.22 uses it well, 
but 2.6.0-test4 doesn't.

I tried add these defs into /etc/modprobe.d/aliases but without success.

When I by hand call for example modprobe hid module is loaded and device 
works.

Can somebody help me?

Michal

