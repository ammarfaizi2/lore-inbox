Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263931AbTEGPME (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 May 2003 11:12:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263967AbTEGPME
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 May 2003 11:12:04 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:20356
	"EHLO lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S263931AbTEGPLE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 May 2003 11:11:04 -0400
Subject: Re: [RFC][PATCH] linux-2.5.69_clear-smi-fix_A0
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: James Cleverdon <jamesclv@us.ibm.com>
Cc: john stultz <johnstul@us.ibm.com>, lkml <linux-kernel@vger.kernel.org>,
       "Martin J. Bligh" <mbligh@aracnet.com>,
       Andrew Grover <andrew.grover@intel.com>
In-Reply-To: <200305070754.08881.jamesclv@us.ibm.com>
References: <1052258319.4503.7.camel@w-jstultz2.beaverton.ibm.com>
	 <200305070754.08881.jamesclv@us.ibm.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1052317498.3061.25.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 07 May 2003 15:24:59 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mer, 2003-05-07 at 15:54, James Cleverdon wrote:
> (I believe there was at least one such system, the Intel Xpress box.  It 
> contained a 486 and seperate APIC chips.)

There are a very very small number with external APIC setups. If I
remember rightly these have a unique APIC version (1 ?) so we can
tell them

