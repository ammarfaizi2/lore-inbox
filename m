Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319652AbSIMOAr>; Fri, 13 Sep 2002 10:00:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319650AbSIMOAq>; Fri, 13 Sep 2002 10:00:46 -0400
Received: from madhouse.demon.co.uk ([158.152.8.97]:61394 "EHLO
	madhouse.demon.co.uk") by vger.kernel.org with ESMTP
	id <S319648AbSIMOAq>; Fri, 13 Sep 2002 10:00:46 -0400
To: <linux-kernel@vger.kernel.org>
From: abuse@madhouse.demon.co.uk (Andrew Bray)
Subject: Extracting CONFIG_IKCONFIG data from 2.4.19-ac4
Date: 13 Sep 2002 13:50:14 GMT
Organization: Private Internet Node
Message-ID: <slrnao3r8m.si3.abuse@madhouse.demon.co.uk>
Reply-To: andy@@chaos.org.uk
X-Trace: madhouse.demon.co.uk 1031925014 16371 127.0.0.1 (13 Sep 2002 13:50:14 GMT)
X-Complaints-To: news@madhouse.demon.co.uk
NNTP-Posting-Date: 13 Sep 2002 13:50:14 GMT
Summary: binoffset ikconfig
User-Agent: slrn/0.9.6.4 (Linux)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I am using kernel 2.4.19-ac4 and I have been looking at using 
CONFIG_IKCONFIG to record the configuration in the kernel image.

I have a question about this:

There is a handy looking script in scripts/extract-ikconfig.  This
uses a command called 'binoffset'.  I have never heard of this, can
anyone point me to a source of binoffset, or an alternative to
extract-ikconfig?

Regards,

Andy

-- 
-----------------------------------------------------------------------------
Andrew Bray, PWMS, MA,              |  preferred:    mailto:andy@chaos.org.uk
London, England                     |  or:   mailto:andy@madhouse.demon.co.uk
PGP id/fingerprint:  D811F5C9/26 B5 42 C6 F4 00 B2 71 BA EA 9B 81 6C 65 59 07

