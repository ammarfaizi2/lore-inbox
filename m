Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161531AbWAMKPO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161531AbWAMKPO (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Jan 2006 05:15:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161533AbWAMKPO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Jan 2006 05:15:14 -0500
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:29410 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1161531AbWAMKPM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Jan 2006 05:15:12 -0500
Subject: Re: [PATCH] Prevent trident driver from grabbing pcnet32 hardware
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Lee Revell <rlrevell@joe-job.com>
Cc: Adrian Bunk <bunk@stusta.de>, Jon Mason <jdmason@us.ibm.com>,
       Muli Ben-Yehuda <mulix@mulix.org>, Jiri Slaby <slaby@liberouter.org>,
       linux-kernel@vger.kernel.org
In-Reply-To: <1137106544.2370.97.camel@mindpipe>
References: <20060112175051.GA17539@us.ibm.com>
	 <43C6ADDE.5060904@liberouter.org>
	 <20060112200735.GD5399@granada.merseine.nu>
	 <20060112214719.GE17539@us.ibm.com> <20060112220039.GX29663@stusta.de>
	 <1137105731.2370.94.camel@mindpipe>  <20060112225205.GZ29663@stusta.de>
	 <1137106544.2370.97.camel@mindpipe>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Fri, 13 Jan 2006 10:16:53 +0000
Message-Id: <1137147413.3645.6.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Iau, 2006-01-12 at 17:55 -0500, Lee Revell wrote:
> "The cyberpro 5050 is an old combined video+audio controller - and
> is/was used in some settop boxes (German Siemens Activity and also
> Loewe).
> 
> There will be no "desktop users" around.

The 5050 is used with some older geode systems. It uses the same core
(from T-squared I believe) as trident and the other vendors. Its not
very different to the 4DWAVE.

Alan
