Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262271AbTFBMfm (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Jun 2003 08:35:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262273AbTFBMfm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Jun 2003 08:35:42 -0400
Received: from rwcrmhc52.attbi.com ([216.148.227.88]:57523 "EHLO
	rwcrmhc52.attbi.com") by vger.kernel.org with ESMTP id S262271AbTFBMfl convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Jun 2003 08:35:41 -0400
Content-Type: text/plain;
  charset="us-ascii"
From: joe briggs <jbriggs@briggsmedia.com>
Organization: BMS
To: LKML <linux-kernel@vger.kernel.org>
Subject: impact of Athlon's slower front-side-bus (FSB)
Date: Mon, 2 Jun 2003 09:47:44 -0400
User-Agent: KMail/1.4.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Message-Id: <200306020947.44520.jbriggs@briggsmedia.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Gentlemen - 

Can anyone provide arguments, evidence, or guidance regarding the followng:

The fastest AMD single processor Athlon XP is 3200 with 400 Mhz FSB.
The fastest AMD dual processor Athlon MP is 2800 but with only 266 Mhz FSB.

So, for a multimedia application, which platform would be faster?  How does 
the much slower FSB of the dual processor impact its ability to grab and 
crunch.  Does its onboard cache make the slower speed FSB less important?  

Also, does a dual processor platform distribute the interrupt loading as well 
as process loading?  I my systems I have between 1 and 8 frame identical 
frame grabbers.  Would the interrupt processing of these devices be 
distributed evenly on the dual processor platforms?
-- 
Joe Briggs
Briggs Media Systems
105 Burnsen Ave.
Manchester NH 01304 USA
TEL/FAX 603-232-3115 MOBILE 603-493-2386
www.briggsmedia.com
