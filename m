Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267446AbUHJGfl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267446AbUHJGfl (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Aug 2004 02:35:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267447AbUHJGfl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Aug 2004 02:35:41 -0400
Received: from pop.gmx.net ([213.165.64.20]:47782 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S267446AbUHJGfc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Aug 2004 02:35:32 -0400
X-Authenticated: #494916
Message-ID: <4118A534.8050903@gmx.de>
Date: Tue, 10 Aug 2004 12:36:36 +0200
From: Peter Schaefer <peter.schaefer@gmx.de>
Reply-To: peter.schaefer@gmx.de
User-Agent: Mozilla Thunderbird 0.7.1 (X11/20040715)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Roger Luethi <rl@hellgate.ch>
CC: linux-kernel@vger.kernel.org
Subject: Re: [VIA-RHINE] Timeouts on EP-HDA3+ Motherboard
References: <41181BF7.6060002@gmx.de> <20040809215424.GA12237@k3.hellgate.ch>
In-Reply-To: <20040809215424.GA12237@k3.hellgate.ch>
X-Enigmail-Version: 0.84.2.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 09.08.2004 23:54, Roger Luethi wrote:
> On Tue, 10 Aug 2004 02:51:03 +0200, Peter Schaefer wrote:
> 
>>I'm getting reproducable errors when Samba is transferring
>>large files:
>>
>>eth0: Transmit timed out, status 0000, PHY status 786d, resetting...
> 
> 
> What kernel? (my crystal ball is in repair)

Oops. I'm sorry, i thought the version number of the driver
might be enough...

The box is currently running 2.6.7 vanilla. I've installed
it starting with 2.6.1 (as 2.4.x doesn't support the hardware
proberly) and the problem has existed ever since.

Best regards,

  Peter


