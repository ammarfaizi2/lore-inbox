Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264471AbTKMXU1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Nov 2003 18:20:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264472AbTKMXU1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Nov 2003 18:20:27 -0500
Received: from smtp.mailbox.net.uk ([195.82.125.32]:41692 "EHLO
	smtp.mailbox.co.uk") by vger.kernel.org with ESMTP id S264471AbTKMXU0
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Nov 2003 18:20:26 -0500
Message-ID: <3FB411A6.9030608@jonmasters.org>
Date: Thu, 13 Nov 2003 23:20:06 +0000
From: Jon Masters <jonathan@jonmasters.org>
Organization: World Organi[sz]ation Of Broken Dreams
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5b) Gecko/20030727 Thunderbird/0.1
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: ppc4xx Ports
X-Enigmail-Version: 0.81.6.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hi there,

I am working on a 405D port using a base kernel of originally 2.4.20 and
now 2.4.21 from kernel.org rather than Montavista etc.

There are several 4xx ports kicking around and each bodges the tlb stuff
in pgtable.h and elsewhere makes simple fixes to make the stock kernel
actually work...though there are several different offerings by now.
Would someone care to share experiences privately about 4xx ports?

Cheers,

Jon.

P.S. The stock 2.4.21 kernel on has a bunch of very trivial bugs (from
losing a register in the syscall handler to breaking shared ptes) and
will not compile correctly out of the box so to speak. A lot of people
seem to be using the Montavista tree as a result. Now rather than
whining I would also like to help so am asking to make contact with
whoever co-ordinates merging these trees together etc.
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQE/tBGmeTyyexZHHxERArrsAJoCLdFQW2+9dffFtCBl/0lvtInh+QCeOG+L
L9EFFKpJSK0jSLMFWXgtXak=
=iIsn
-----END PGP SIGNATURE-----

