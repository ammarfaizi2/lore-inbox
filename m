Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751007AbWERXYt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751007AbWERXYt (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 May 2006 19:24:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751024AbWERXYt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 May 2006 19:24:49 -0400
Received: from hu-out-0102.google.com ([72.14.214.193]:22876 "EHLO
	hu-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1751001AbWERXYt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 May 2006 19:24:49 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:subject:from:to:cc:content-type:date:message-id:mime-version:x-mailer:content-transfer-encoding;
        b=pKBhTthyHJz956f/QE6BepyvRw1PUBl4KV77xgQ4VoCqiKKnkVdwYFyy1fLpCWgjTCtuW90pk/hlKewp87Kb41/hNLGR72iUKXx8M6h+a3oQVDLuoUubHXNHpmRkI/bR2wBZ1TVShCkKrQVuDz2U2PgezG2GNcNzGZJiDGhLGL8=
Subject: [PATCH 0/2] tpm: bios log parsing fixes
From: Seiji Munetoh <seiji.munetoh@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: kjhall@us.ibm.com, tpmdd-devel@lists.sourceforge.net
Content-Type: text/plain
Date: Fri, 19 May 2006 08:25:11 +0900
Message-Id: <1147994711.14102.63.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-27) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This following patch set fixes
PATCH 1/2) eventlog parser to get the correct ASCII output
PATCH 2/2) changes the BINARY output to the actual ACPI log structure.

--
Seiji Munetoh



