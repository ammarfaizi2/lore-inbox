Return-Path: <linux-kernel-owner+w=401wt.eu-S932659AbWLMKiN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932659AbWLMKiN (ORCPT <rfc822;w@1wt.eu>);
	Wed, 13 Dec 2006 05:38:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932660AbWLMKiN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Dec 2006 05:38:13 -0500
Received: from tmailer.gwdg.de ([134.76.10.23]:36669 "EHLO tmailer.gwdg.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932659AbWLMKiM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Dec 2006 05:38:12 -0500
X-Greylist: delayed 2225 seconds by postgrey-1.27 at vger.kernel.org; Wed, 13 Dec 2006 05:38:12 EST
Date: Wed, 13 Dec 2006 10:59:21 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Silviu Craciunas <silviu.craciunas@sbg.ac.at>
cc: Brice Goglin <Brice.Goglin@ens-lyon.org>, linux-kernel@vger.kernel.org
Subject: Re: get device from file struct
In-Reply-To: <1165914248.30185.41.camel@ThinkPadCK6>
Message-ID: <Pine.LNX.4.61.0612131059100.25870@yvahk01.tjqt.qr>
References: <1165850548.30185.18.camel@ThinkPadCK6>  <457DA4A0.4060108@ens-lyon.org>
 <1165914248.30185.41.camel@ThinkPadCK6>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Report: Content analysis: 0.0 points, 6.0 required
	_SUMMARY_
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>thanks for the reply, the block device can be determined with the major
>and minor numbers , what I would be more interested in is if one can get
>the net_device struct from the file struct

Just how are you supposed to match files and network devices?


	-`J'
-- 
