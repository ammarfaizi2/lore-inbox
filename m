Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263340AbTDVSgj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Apr 2003 14:36:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263343AbTDVSgj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Apr 2003 14:36:39 -0400
Received: from siaab1ab.compuserve.com ([149.174.40.2]:35834 "EHLO
	siaab1ab.compuserve.com") by vger.kernel.org with ESMTP
	id S263340AbTDVSgi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Apr 2003 14:36:38 -0400
Date: Tue, 22 Apr 2003 14:44:48 -0400
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: Re: 2.4.x high irq contention
To: linux-kernel <linux-kernel@vger.kernel.org>
Message-ID: <200304221448_MC3-1-3589-7226@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>> Won't help a lot. If its all IRQ load (eg lots of multicast streaming
>> audio small frames) then you want an eepro100 or something similar that
>> has interrupt mitigators.
>
> Well, handwaving about the network load/type ;-)
> Could as well be two RTL back-to-back, normal packets but high bandwidth. 
> (watch collisions for this case :-)


  RTL-8139: the hardware equivalent of a bicycle.

  8))
------
 Chuck
