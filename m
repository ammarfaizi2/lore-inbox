Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261682AbVB1UC0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261682AbVB1UC0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Feb 2005 15:02:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261704AbVB1UC0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Feb 2005 15:02:26 -0500
Received: from h-64-105-159-118.phlapafg.covad.net ([64.105.159.118]:39082
	"HELO roinet.com") by vger.kernel.org with SMTP id S261682AbVB1UCX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Feb 2005 15:02:23 -0500
Subject: Re: [PATCH] orinoco rfmon
From: Pavel Roskin <proski@gnu.org>
To: David Gibson <hermes@gibson.dropbear.id.au>
Cc: Eric Gaumer <gaumerel@ecs.fullerton.edu>, linux-kernel@vger.kernel.org
In-Reply-To: <20050228005410.GB9197@localhost.localdomain>
References: <4220BB87.2010806@ecs.fullerton.edu>
	 <20050227033944.GA15380@localhost.localdomain>
	 <422269BA.9070308@ecs.fullerton.edu>
	 <20050228005410.GB9197@localhost.localdomain>
Content-Type: text/plain
Date: Mon, 28 Feb 2005 15:01:52 -0500
Message-Id: <1109620912.29023.8.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.1.5 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

>> I just disabled the check for broken firmware and things seem fine (better 
>> than the original
>> patch I posted). The iwlist command now works. Could the buggy firmware be 
>> generalized a bit
>> too much? Perhaps only certain versions > 8 are buggy?
>
>Possibly, but I don't really have the means to find out in more
>detail.  The trouble is that when it falls over, it falls over very
>badly, which is why we disable this rather than just letting the user
>risk it.  Pavel knows more of the details on this one.
>
Try AirSnort with scanning enabled - it will bring the firmware down in
a few minutes.

-- 
Regards,
Pavel Roskin


