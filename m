Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265880AbUAIBhF (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jan 2004 20:37:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265895AbUAIBhF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jan 2004 20:37:05 -0500
Received: from smtp06.auna.com ([62.81.186.16]:34251 "EHLO smtp06.retemail.es")
	by vger.kernel.org with ESMTP id S265880AbUAIBhC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Jan 2004 20:37:02 -0500
Date: Fri, 9 Jan 2004 02:36:58 +0100
From: "J.A. Magallon" <jamagallon@able.es>
To: Lista Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: [OT] Date info in listings from ftp.kernel.org
Message-ID: <20040109013658.GI2706@werewolf.able.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7BIT
X-Mailer: Balsa 2.0.15
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all...

Is this a bug in ftp servers ?

-rw-rw-r--   1 korg     korg       867164 Dec 31 05:46 patch-2.6.1-rc1.gz
-rw-rw-r--   1 korg     korg          248 Dec 31 05:46 patch-2.6.1-rc1.gz.sign
-rw-rw-r--   1 korg     korg          248 Dec 31 05:46 patch-2.6.1-rc1.sign
-rw-rw-r--   1 korg     korg       749822 Jan  6 06:51 patch-2.6.1-rc2.bz2
-rw-rw-r--   1 korg     korg          248 Jan  6 06:51 patch-2.6.1-rc2.bz2.sign
-rw-rw-r--   1 korg     korg       896088 Jan  6 06:51 patch-2.6.1-rc2.gz

Clients relay on year being present to set it, else it is set to 2004.
So they suppose rc1 was released on Dec 31 2004.

Some way to get a listing with full year info ?

TIA

-- 
J.A. Magallon <jamagallon()able!es>     \                 Software is like sex:
werewolf!able!es                         \           It's better when it's free
Mandrake Linux release 10.0 (Cooker) for i586
Linux 2.6.1-rc1-jam2 (gcc 3.3.2 (Mandrake Linux 10.0 3.3.2-3mdk))
