Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262133AbUC2Ukl (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Mar 2004 15:40:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262217AbUC2Ukl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Mar 2004 15:40:41 -0500
Received: from dsl081-235-061.lax1.dsl.speakeasy.net ([64.81.235.61]:50084
	"EHLO ground0.sonous.com") by vger.kernel.org with ESMTP
	id S262133AbUC2Ukj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Mar 2004 15:40:39 -0500
Mime-Version: 1.0 (Apple Message framework v613)
Content-Transfer-Encoding: 7bit
Message-Id: <5516F046-81C1-11D8-A0A8-000A959DCC8C@sonous.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed
To: linux-kernel@vger.kernel.org
From: Lev Lvovsky <lists1@sonous.com>
Subject: older kernels + new glibc?
Date: Mon, 29 Mar 2004 12:40:36 -0800
X-Mailer: Apple Mail (2.613)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I'm not sure what, if any interrelations there are between the various 
versions of glibc, and the kernel.

Specifically, a piece of telecom hardware that we use out in the field 
requires a 2.2.x kernel to compile the drivers, however, after choosing 
an arbitrary "new" release of a linux distro, and downgrading the 
kernel, we are able to compile and install the drivers, and 
subsequently use the hardware.

Are there any URLs/Docs that I could look at to understand what, if any 
relationships glibc, and the kernel have?

thank you!
-lev

