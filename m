Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262153AbUANRDi (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jan 2004 12:03:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264329AbUANRDi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jan 2004 12:03:38 -0500
Received: from ss1000.ms.mff.cuni.cz ([195.113.19.221]:46266 "EHLO
	ss1000.ms.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S262153AbUANRDh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jan 2004 12:03:37 -0500
Date: Wed, 14 Jan 2004 18:03:17 +0100
From: Rudo Thomas <rudo@matfyz.cz>
To: Jesse Pollard <jesse@cats-chateau.net>
Subject: Re: Catch 22
Message-ID: <20040114170317.GA25122@ss1000.ms.mff.cuni.cz>
References: <400554C3.4060600@sms.ed.ac.uk> <20040114090137.5586a08c.jkl@sarvega.com> <04011410503200.32256@tabby>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <04011410503200.32256@tabby>
User-Agent: Mutt/1.5.4i-ja.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Also you can use a MBR lilo that only boots one or more partitions, then
> have Lilo installed on each partition to select a specific kernel related
> to that particular partition. This way you no longer have to update a
> single point of failure - only update the lilo configuration on a specific
> partition when changes are needed.
> 
> You avoid altering the MBR and the other partition.

I think the original poster meant one partition. In 2.4 it shows up as
/dev/hda, in 2.6 as /dev/hde.

Rudo.
