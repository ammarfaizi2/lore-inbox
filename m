Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279946AbRJ3Mbo>; Tue, 30 Oct 2001 07:31:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279947AbRJ3Mbe>; Tue, 30 Oct 2001 07:31:34 -0500
Received: from gate.tao-group.com ([62.255.240.131]:11527 "EHLO
	mail.tao-group.com") by vger.kernel.org with ESMTP
	id <S279946AbRJ3MbS>; Tue, 30 Oct 2001 07:31:18 -0500
Subject: [RFC] 2.4.11-dontuse packages
From: Andrew Ebling <andrew_ebling@tao-group.com>
To: ftpadmin@kernel.org
Cc: linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.16.99+cvs.2001.10.28.14.02 (Preview Release)
Date: 30 Oct 2001 12:31:29 +0000
Message-Id: <1004445089.485.17.camel@spinel>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

(Really for ftpadmin@kernel.org but CC'd to lkml for discussion
purposes.)

Dear Sir/Madam,

**Request for change regarding naming of 2.4.11-dontuse packages**

I am currently working on the patch-kernel scripts included with the 
kernel source code to add functionality to automate the process of
downloading and applying successive patches from the users nearest
kernel mirror.

Would it be possible to return the 2.4.11* packages to the standard
naming convention and use some other method to indicate that kernel
version 2.4.11 should not be used?  (e.g. put another empty file in the
directory called "patch-2.4.11-dont-use" rather than breaking the naming
convention).

Of course, I could put an ugly work around in the script for 2.4.11, but
keeping the standard naming convention would be a better solution.  I do
plan to warn users if they use the script to request kernel version
2.4.11, but unfortunately, use of the 2.4.11 patch is neccessary to get
to 2.4.12 and above.

Thank you for your time,

Andrew Ebling





