Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265291AbUATJUT (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jan 2004 04:20:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265296AbUATJUT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jan 2004 04:20:19 -0500
Received: from mout1.freenet.de ([194.97.50.132]:717 "EHLO mout1.freenet.de")
	by vger.kernel.org with ESMTP id S265291AbUATJUP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jan 2004 04:20:15 -0500
From: Andreas Hartmann <andihartmann@freenet.de>
X-Newsgroups: fa.linux.kernel
Subject: Re: TG3: very high CPU usage
Date: Tue, 20 Jan 2004 10:17:38 +0100
Organization: privat
Message-ID: <buirni$2t4$1@A88a8.a.pppool.de>
References: <fa.g9joqss.1nneajs@ifi.uio.no> <fa.e29fqcc.sick10@ifi.uio.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Complaints-To: abuse@fu.berlin.de
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040116
X-Accept-Language: de, en-us, en
In-Reply-To: <fa.e29fqcc.sick10@ifi.uio.no>
X-Enigmail-Version: 0.82.5.0
X-Enigmail-Supports: pgp-inline, pgp-mime
To: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I searched for tg3 in lkml and found one more posting, dealing with these 
problems (subject):

bcm5705 with tg3 driver and high rx load -> bad system responsiveness

There really seems to be a problem. Ronald Wahl pointed out, that the 
driver from
http://www.broadcom.com/drivers/downloaddrivers.php does not have the 
problem. Maybe, we could both look for drivers from the hardware producer 
and test them? I will do it when I'm back at work in two weeks.


Regards,
Andreas Hartmann
