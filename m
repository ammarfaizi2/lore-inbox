Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269703AbUJSUhS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269703AbUJSUhS (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Oct 2004 16:37:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269896AbUJSUgQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Oct 2004 16:36:16 -0400
Received: from c7ns3.center7.com ([216.250.142.14]:46767 "EHLO
	smtp.slc03.viawest.net") by vger.kernel.org with ESMTP
	id S268138AbUJSUZZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Oct 2004 16:25:25 -0400
Message-ID: <41756F63.2090309@drdos.com>
Date: Tue, 19 Oct 2004 13:47:47 -0600
From: "Jeff V. Merkey" <jmerkey@drdos.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040510
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Diego Calleja <diegocg@teleline.es>
Cc: riel@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: Linux v2.6.9 and GPL Buyout
References: <Pine.LNX.4.44.0410191530060.18723-100000@chimarrao.boston.redhat.com>	<4175657E.7040800@drdos.com> <20041019221457.3ad7dbea.diegocg@teleline.es>
In-Reply-To: <20041019221457.3ad7dbea.diegocg@teleline.es>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Diego Calleja wrote:

>Just wondering, how did you remove RCU? From a quick grep it's used in generic
>code like fs/dcache.c or kernel/sched.c. Did you remove process scheduler and
>filesystem support for your customers too? Or I'm missing something about RCU?
>-
>  
>
That's one's a mess.  Looks like some late nights.  I guess we could 
claim "essential facility" on this one,
this will be some serious work ......

Jeff
