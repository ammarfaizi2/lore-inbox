Return-Path: <linux-kernel-owner+w=401wt.eu-S1753737AbWLWUOF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753737AbWLWUOF (ORCPT <rfc822;w@1wt.eu>);
	Sat, 23 Dec 2006 15:14:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753743AbWLWUOF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Dec 2006 15:14:05 -0500
Received: from e5.ny.us.ibm.com ([32.97.182.145]:55999 "EHLO e5.ny.us.ibm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753737AbWLWUOC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Dec 2006 15:14:02 -0500
Message-ID: <458D8E38.4090303@us.ibm.com>
Date: Sat, 23 Dec 2006 14:14:48 -0600
From: Steve French <smfltc@us.ibm.com>
User-Agent: Thunderbird 1.5.0.9 (X11/20061206)
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: 2.6.19-rc1 build problem
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Is this a know problem with very current 2.6.19-rc?

Building modules, stage 2.
MODPOST 443 modules
WARNING: "bitrev32" [drivers/net/8139cp.ko] undefined!
WARNING: "serio_register_driver" [drivers/input/touchscreen/mtouch.ko] 
undefined!
(repeated many times)
