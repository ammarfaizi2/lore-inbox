Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750847AbVI2C12@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750847AbVI2C12 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Sep 2005 22:27:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751315AbVI2C12
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Sep 2005 22:27:28 -0400
Received: from ausc60ps301.us.dell.com ([143.166.148.206]:16536 "EHLO
	ausc60ps301.us.dell.com") by vger.kernel.org with ESMTP
	id S1750847AbVI2C11 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Sep 2005 22:27:27 -0400
X-IronPort-AV: i="3.97,155,1125896400"; 
   d="scan'208"; a="300611961:sNHT32540180"
X-MIMEOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 8BIT
Subject: RE: [RFC][patch 2.6.14-rc2] dell_rbu: Changing packet update mechanism
Date: Wed, 28 Sep 2005 21:27:26 -0500
Message-ID: <597A2BC19EDD3C458F841E8724E92D4B973E26@ausx3mps301.aus.amer.dell.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [RFC][patch 2.6.14-rc2] dell_rbu: Changing packet update mechanism
Thread-index: AcXEiH7b8ZPlreSbSWmrGaI8G871wAAFI3sg
From: <Abhay_Salunke@Dell.com>
To: <jesper.juhl@gmail.com>
Cc: <linux-kernel@vger.kernel.org>, <akpm@osdl.org>
X-OriginalArrivalTime: 29 Sep 2005 02:27:27.0512 (UTC) FILETIME=[559BF180:01C5C49D]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 

-----Original Message-----
From: Jesper Juhl [mailto:jesper.juhl@gmail.com] 
Sent: Wednesday, September 28, 2005 7:01 PM
To: Salunke, Abhay
Cc: linux-kernel@vger.kernel.org; akpm@osdl.org
Subject: Re: [RFC][patch 2.6.14-rc2] dell_rbu: Changing packet update
mechanism

On Friday 23 September 2005 21:40, Abhay Salunke wrote:
> Please ignore earlier patches as there was error submitting it! :-( 
> patch below is good...
> 

Ok, I'm being pedantic. So shoot me.
There are a few tiny bits CodingStyle wise that could be better. No big
deal, I'm nitpicking in the extreme here...

All of this code was ran thourgh Lindent!.
BTW there is a new patch which might have covered your concers.

Thanks
Abhay
