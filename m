Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263568AbUBIITT (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Feb 2004 03:19:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264339AbUBIITT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Feb 2004 03:19:19 -0500
Received: from terminus.zytor.com ([63.209.29.3]:38797 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S263568AbUBIITS
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Feb 2004 03:19:18 -0500
Message-ID: <40274277.5080808@zytor.com>
Date: Mon, 09 Feb 2004 00:19:03 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6b) Gecko/20040105
X-Accept-Language: en, sv, es, fr
MIME-Version: 1.0
To: Ricky Beam <jfbeam@bluetronic.net>
CC: Linux Kernel Mail List <linux-kernel@vger.kernel.org>
Subject: Re: Does anyone still care about BSD ptys?
References: <Pine.GSO.4.33.0402090309000.28488-100000@sweetums.bluetronic.net>
In-Reply-To: <Pine.GSO.4.33.0402090309000.28488-100000@sweetums.bluetronic.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ricky Beam wrote:
> On Sun, 8 Feb 2004, H. Peter Anvin wrote:
> 
>>Right, this is basically for 2.6/2.7 depending on if there are any
>>stragglers who still use these things...
> 
> nettty (whatever you may find it named) uses the BSD pty interface.  I don't
> know how much work it would be to get it to use /dev/pts.  I've not used it
> for many years, so I cannot say anyone would care if it stopped working.
> 
> The code is at least 7 years old (originally written by Livingston.)
> 

The porting effort is usually trivial assuming one has access to the source.

	-hpa
