Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264257AbTLEPmH (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Dec 2003 10:42:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264258AbTLEPmH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Dec 2003 10:42:07 -0500
Received: from utility.invlogic.com ([198.182.196.8]:7345 "EHLO
	utility.invlogic.com") by vger.kernel.org with ESMTP
	id S264257AbTLEPmF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Dec 2003 10:42:05 -0500
Message-Id: <200312051542.hB5Fg4pU020471@utility.invlogic.com>
From: "Michael McLagan" <mmclagan@invlogic.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Date: Fri, 05 Dec 2003 10:42:02 -0500 (EST)
Reply-To: "Michael McLagan" <mmclagan@invlogic.com>
X-Mailer: PMMail 2.20.2382 for OS/2 Warp 3.0
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Subject: 2.4.23 + P3TDE6 (Supermicro) + AGP -> Endless loop during boot
X-Envelope-Sender: <mmclagan@invlogic.com>
X-Envelope-Source: 198.182.196.9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

   The above combination results in an endless loop during kernel boot, 
filling the screen with:

      Posted write buffer flush took more than 3 seconds
      Posted write buffer flush took more than 3 seconds
      Posted write buffer flush took more than 3 seconds

   The board uses Serverworks Serverset III HE-SL.  Is there a BIOS 
config or patch that gets around this ?

   Thanks,

   Michael


