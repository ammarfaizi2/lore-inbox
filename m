Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750769AbVI1UbP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750769AbVI1UbP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Sep 2005 16:31:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750827AbVI1UbO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Sep 2005 16:31:14 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:12787 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S1750769AbVI1UbO
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Sep 2005 16:31:14 -0400
Subject: Re: 2.6.14-rc2-rt6 build problems
From: Daniel Walker <dwalker@mvista.com>
Reply-To: dwalker@mvista.com
To: Mark Knecht <markknecht@gmail.com>
Cc: linux-kernel@vger.kernel.org, Ingo Molnar <mingo@elte.hu>
In-Reply-To: <5bdc1c8b05092813131955ab8f@mail.gmail.com>
References: <5bdc1c8b05092808596a22847a@mail.gmail.com>
	 <5bdc1c8b05092813131955ab8f@mail.gmail.com>
Content-Type: text/plain
Organization: MontaVista
Date: Wed, 28 Sep 2005 13:30:55 -0700
Message-Id: <1127939455.9378.1.camel@dhcp153.mvista.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-09-28 at 13:13 -0700, Mark Knecht wrote:

> 1) I downloaded 2.6.13 and built this correctly.
> 
> 2) I applied the 2.6.14-rc2 patch. This built correctly also.
> 
> 3) I applied the 2.6.14-rc2-rt5 patch. It failed as foloows:

You had "Complete Preemption (Real-Time)" selected in the first config
you sent, did you have that selected during this compile also ?

Daniel

