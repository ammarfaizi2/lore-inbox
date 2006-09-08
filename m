Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751031AbWIHRs4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751031AbWIHRs4 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Sep 2006 13:48:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751032AbWIHRs4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Sep 2006 13:48:56 -0400
Received: from mga01.intel.com ([192.55.52.88]:1950 "EHLO mga01.intel.com")
	by vger.kernel.org with ESMTP id S1751027AbWIHRsz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Sep 2006 13:48:55 -0400
X-ExtLoop1: 1
X-IronPort-AV: i="4.09,134,1157353200"; 
   d="scan'208"; a="127688507:sNHT577067316"
Date: Fri, 8 Sep 2006 10:48:45 -0700
From: Kristen Carlson Accardi <kristen.c.accardi@intel.com>
To: Nigel Cunningham <ncunningham@linuxmail.org>
Cc: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
       len.brown@intel.com
Subject: Re: patch [0/2]: acpi: add generic removable drive bay support
Message-Id: <20060908104845.c67b173d.kristen.c.accardi@intel.com>
In-Reply-To: <1157679256.3474.48.camel@nigel.suspend2.net>
References: <20060907161305.67804d14.kristen.c.accardi@intel.com>
	<1157679256.3474.48.camel@nigel.suspend2.net>
X-Mailer: Sylpheed version 2.2.6 (GTK+ 2.8.20; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 08 Sep 2006 11:34:16 +1000
Nigel Cunningham <ncunningham@linuxmail.org> wrote:

> Hi Kristen.
> 
> Great to see this!
> 
> Allow me to anticipate a question I'm sure will come: will this play
> well with (say) suspending while docked and resuming undocked?
> 

Hi Nigel,
I don't know.  the few experiments that I've tried with suspend/resume are
not inspiring.  I don't think that suspend/resume works at all with the
dock station ATM.  "warm plug" is something that is on my list of things
to work on after hot plug actually works.

Kristen
