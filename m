Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264850AbTFLWTi (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Jun 2003 18:19:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265024AbTFLWTi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Jun 2003 18:19:38 -0400
Received: from cox.ee.ed.ac.uk ([129.215.80.253]:7341 "EHLO
	postbox.ee.ed.ac.uk") by vger.kernel.org with ESMTP id S264850AbTFLWTh convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Jun 2003 18:19:37 -0400
From: Unai Garro Arrazola <Unai.Garro@ee.ed.ac.uk>
Organization: The University of Edinburgh
To: linux-kernel@vger.kernel.org
Subject: 2.5.70: Lilo needs patching?
Date: Thu, 12 Jun 2003 23:29:38 +0100
User-Agent: KMail/1.5.9
Cc: linux-mm@vger.kernel.org
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Message-Id: <200306122329.47365.Unai.Garro@ee.ed.ac.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Since version 2.5.69 (now with 2.5.70-mm6), I'm having trouble using lilo. 
Every time I try to change the lilo boot, the boot menu is either not 
changed, or it's corrupted. It looks like if Lilo doesn't manage to 
completely write the boot sector.

I've been looking around, but I haven't found any information about this. Has 
anything changed in the latest versions? Are there any patches that I need to 
apply to lilo to make it work now? 

Thanks in advance

[Please, if you don't mind,  CC me off this list. I can't subscribe to it due 
to the high volume of mails it has every day. Thanks.]

	Unai
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE+6P7YhxDfDIoZlaURAv8zAJ9Kbd5rDgACuwP7vXcysKshdOcqtgCeNBfZ
WQ7tTe2kJzEgubPRCKxg69U=
=51n8
-----END PGP SIGNATURE-----
