Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284138AbSAUK4Q>; Mon, 21 Jan 2002 05:56:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282978AbSAUK4G>; Mon, 21 Jan 2002 05:56:06 -0500
Received: from smtp1.ndsu.NoDak.edu ([134.129.111.146]:55050 "EHLO
	smtp1.ndsu.nodak.edu") by vger.kernel.org with ESMTP
	id <S282902AbSAUK4D>; Mon, 21 Jan 2002 05:56:03 -0500
Subject: Athlon PSE/AGP Bug
From: Reid Hekman <reid.hekman@ndsu.nodak.edu>
To: linux-kernel@vger.kernel.org
Cc: akpm@zip.com.au, alan@lxorg.ukuu.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0.1 
Date: 21 Jan 2002 04:53:39 -0600
Message-Id: <1011610422.13864.24.camel@zeus>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

The folks at Gentoo Linux have published a news item about AGP related
lockups with PSE on AMD Athlons. 

As I have a couple systems that may/may not be affected, I'm seeking
some clarification. Is this an effect of the errata published by AMD in
the Athlon models 4 & 6 revision guides as "INVLPG Instruction Does Not
Flush Entire Four-Megabyte Page Properly with Certain Linear Addresses"?
That errata lists all Athlon Thunderbirds as affected and all Athlon
Palominos except for stepping A5. 

Regardless of specific errata listings, will future workarounds be
enabled based on cpuid or via a test for the bug itself?

Regards,
Reid

