Return-Path: <linux-kernel-owner+w=401wt.eu-S1751283AbXAUHW2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751283AbXAUHW2 (ORCPT <rfc822;w@1wt.eu>);
	Sun, 21 Jan 2007 02:22:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751294AbXAUHW2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Jan 2007 02:22:28 -0500
Received: from terminus.zytor.com ([192.83.249.54]:54455 "EHLO
	terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751283AbXAUHW1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Jan 2007 02:22:27 -0500
Message-ID: <45B314B0.4020907@zytor.com>
Date: Sat, 20 Jan 2007 23:22:24 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Thunderbird 1.5.0.9 (X11/20061219)
MIME-Version: 1.0
To: Udo van den Heuvel <udovdh@xs4all.nl>
CC: linux-kernel@vger.kernel.org, Greg KH <greg@kroah.com>
Subject: Re: USB extension (repeater) cable
References: <45B0E672.4080404@xs4all.nl> <20070120000158.GD12615@kroah.com> <45B313AD.7080705@zytor.com> <45B31433.5000408@xs4all.nl>
In-Reply-To: <45B31433.5000408@xs4all.nl>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Udo van den Heuvel wrote:
> 
>> Actually, what it looks like is even simpler.  The extension cable
>> contains a four-port hub chip (which is the most common commodity chip)
>> and haven't bothered changing the descriptor to tell the computer only
>> one port is actually active.  So only one port can be activated, and the
>> others are stubbed out in some evil way.  In that case, it should be
>> noisy but harmless.
> 
> I will do some more testing then.
> Is there a way to get rid of the messages?

No, but you don't have to care about them.

	-hpa
