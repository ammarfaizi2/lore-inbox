Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268317AbUHLEFP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268317AbUHLEFP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Aug 2004 00:05:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268380AbUHLEFP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Aug 2004 00:05:15 -0400
Received: from ns1.skjellin.no ([80.239.42.66]:647 "HELO mail.skjellin.no")
	by vger.kernel.org with SMTP id S268317AbUHLEFL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Aug 2004 00:05:11 -0400
Message-ID: <411AEC7A.2060402@tomt.net>
Date: Thu, 12 Aug 2004 06:05:14 +0200
From: Andre Tomt <andre@tomt.net>
User-Agent: Mozilla Thunderbird 0.7.3 (X11/20040805)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Robert M. Stockmann" <stock@stokkie.net>
CC: linux-kernel@vger.kernel.org
Subject: Re: PATCH: cdrecord: avoiding scsi device numbering for ide devices
References: <Pine.LNX.4.44.0408120347290.1628-100000@hubble.stokkie.net>
In-Reply-To: <Pine.LNX.4.44.0408120347290.1628-100000@hubble.stokkie.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Robert M. Stockmann wrote:
> Its indeed not straight forward to use cdrtools-2.0x together with
> kernel 2.6.x . As an aid for the user, i wrote a small HOWTO for using 
> cdrtools together with kernel 2.6, with special focus on retrieval
> of which device names to use. The small HOWTO can be found on :
> 
> http://crashrecovery.org/oss-dvd/HOWTO-ossdvd.html

Whats not straight forward with dev=/dev/device-of-cdr ?
