Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268147AbTB1Uif>; Fri, 28 Feb 2003 15:38:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268149AbTB1Uie>; Fri, 28 Feb 2003 15:38:34 -0500
Received: from e35.co.us.ibm.com ([32.97.110.133]:9883 "EHLO e35.co.us.ibm.com")
	by vger.kernel.org with ESMTP id <S268147AbTB1Uib>;
	Fri, 28 Feb 2003 15:38:31 -0500
Date: Fri, 28 Feb 2003 12:39:40 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [Bug 422] New: compiler warning from sound/pci/ac97/ac97_codec.c
 (fwd)
Message-ID: <344920000.1046464780@flay>
X-Mailer: Mulberry/2.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


http://bugme.osdl.org/show_bug.cgi?id=422

           Summary: compiler warning from sound/pci/ac97/ac97_codec.c
    Kernel Version: 2.5.63
            Status: NEW
          Severity: normal
             Owner: bugme-janitors@lists.osdl.org
         Submitter: mbligh@aracnet.com


compiler warning (gcc 2.95.4) 


sound/pci/ac97/ac97_codec.c: In function `snd_ac97_tune_hardware':
sound/pci/ac97/ac97_codec.c:2477: warning: unused variable `q'

Oddly, it doesn't seem to have a variable called 'q'.


