Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932309AbWDUN4N@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932309AbWDUN4N (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Apr 2006 09:56:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932312AbWDUN4N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Apr 2006 09:56:13 -0400
Received: from imr2.ericy.com ([198.24.6.3]:37016 "EHLO imr2.ericy.com")
	by vger.kernel.org with ESMTP id S932309AbWDUN4L (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Apr 2006 09:56:11 -0400
Message-ID: <4448AC62.6090303@ericsson.com>
Date: Fri, 21 Apr 2006 09:56:50 +0000
X-Sybari-Trust: 08e0ac33 13c6c8f3 f0b8360b 00000139
From: Makan Pourzandi <Makan.Pourzandi@ericsson.com>
User-Agent: Thunderbird 1.5 (X11/20051201)
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org
CC: Serue Hallyen <serue@us.ibm.com>,
       Axelle Apvrille <axelle_apvrille@rc1.vip.ukl.yahoo.com>,
       "'disec-devel@lists.sourceforge.net'" 
	<disec-devel@lists.sourceforge.net>
Subject: [ANNOUNCE] Release Digsig 1.5: kernel module for run-time authentication
 of binaries
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Digsig development team would like to announce the release 1.5 of digsig.

This kernel module helps system administrators control Executable and 
Linkable Format (ELF) binary execution and library loading based on
the presence of a valid digital signature.  The main functionality is
to help system administrators distinguish applications he/she trusts
(and therefore signs) from viruses, worms (and other nuisances). It is
based on the Linux Security Module hooks.

The code is GPL and available from:
http://sourceforge.net/projects/disec/, download digsig-1.5. For
more documentation, please refer to disec.sourcefrge.net.

We hope that it'll be useful to you.

All bug reports and feature requests or general feedback are welcome
(please CC me and disec-devel@lists.sourceforge.net in your answer or 
feedback to the mailing list).

Regards,
Makan Pourzandi

-- 

Makan Pourzandi, Open Systems Lab
Ericsson Research, Montreal, Canada
*This email does not represent or express the opinions of Ericsson Inc.*

