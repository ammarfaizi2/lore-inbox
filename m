Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264631AbSKVMTU>; Fri, 22 Nov 2002 07:19:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264639AbSKVMTT>; Fri, 22 Nov 2002 07:19:19 -0500
Received: from ns.tasking.nl ([195.193.207.2]:524 "EHLO ns.tasking.nl")
	by vger.kernel.org with ESMTP id <S264631AbSKVMTT>;
	Fri, 22 Nov 2002 07:19:19 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15838.8775.731832.967888@koli.tasking.nl>
Date: Fri, 22 Nov 2002 13:25:43 +0100
From: Kees Bakker <rnews@altium.nl>
To: linux-kernel@vger.kernel.org
Subject: How to migrate from modutils to module-init-tools?
X-Mailer: VM 7.03 under Emacs 20.7.2
Reply-To: kees.bakker@altium.nl (Kees Bakker)
Organisation: ALTIUM Software B.V.
X-Bill: Go away
X-Attribution: kb
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Since 2.5.48 I seem to be needing module-init-tools. Is there documentation
that describes what I must do to use/install module-init-tools? And how do
I set up my system if I want to boot older kernels as well?

I have downloaded module-init-tools 0.7, but the command interface of
the new modprobe is not the same as the old one. In other words if I
install module-init-tools I cannot boot pre 2.5.48 without many errors
loading the modules. Is there a way to solve this?
-- 
