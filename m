Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263082AbUACN0f (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Jan 2004 08:26:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263130AbUACN0c
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Jan 2004 08:26:32 -0500
Received: from lapd.cj.edu.ro ([193.231.142.101]:13441 "HELO lapd.cj.edu.ro")
	by vger.kernel.org with SMTP id S262913AbUACN0b (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Jan 2004 08:26:31 -0500
Date: 3 Jan 2004 15:26:30 +0200
Date: Sat, 3 Jan 2004 15:26:30 +0200 (EET)
From: "Cosmin Matei \(lkml\)" <linux@lapd.cj.edu.ro>
To: linux-kernel@vger.kernel.org
Subject: Kernel 2.4.24-pre3 and ip_gre module ...
Message-ID: <Pine.LNX.4.51L0.0401031512090.2488@lapd.cj.edu.ro>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

I'm trying to use the new kernel 2.4.23 + 2.4.24-pre3 patch and the first 
impression is very good. Just one problem appears to make me to reconsider 
using 2.4.24-pre3: ip_gre module it's not working!!! The module is 
loading, the interface it's bringing up but no packets pass thru ... what 
can I do? There is any modifications from 2.4.21-rc6?

Thank you,
Cosmin
