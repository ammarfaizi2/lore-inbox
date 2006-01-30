Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964929AbWA3XQc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964929AbWA3XQc (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Jan 2006 18:16:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965037AbWA3XQc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Jan 2006 18:16:32 -0500
Received: from e34.co.us.ibm.com ([32.97.110.152]:8628 "EHLO e34.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S964929AbWA3XQb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Jan 2006 18:16:31 -0500
Message-ID: <43DE9E97.7080709@us.ibm.com>
Date: Mon, 30 Jan 2006 17:17:43 -0600
From: "V. Ananda Krishnan" <mansarov@us.ibm.com>
User-Agent: Thunderbird 1.5 (X11/20051201)
MIME-Version: 1.0
To: Greg KH <gregkh@suse.de>
CC: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Adrian Bunk <bunk@stusta.de>,
       Scott_Kilau@digi.com
Subject: Re: [RFC: linux-2.6.16-rc1 patch] jsm: fix for high baud rates problem
References: <43DE30F1.6040107@us.ibm.com> <20060130185808.GA17533@suse.de>
In-Reply-To: <20060130185808.GA17533@suse.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH wrote:
> On Mon, Jan 30, 2006 at 09:29:53AM -0600, V. Ananda Krishnan wrote:
>> Digi serial port console doesn't work when baud rates are set higher 
>> than 38400.  So the lookup table and code in jsm_neo.c has been modified 
>> and tested.  Please let me have the feed-back.
>>
>> Thanks,
>> V. Ananda Krishnan
>>
>>
>>
>> Authors: Scott Kilau and V. Ananda Krishnan
>> Signed-off-by: V.Ananda Krishnan
> 
> Wrong Signed-off-by: format :(
> 
> 
Sorry for the error.  Signing off again. Hope this format is o.k.
Signed-off-by: V. Ananda Krishnan <mansarov@us.ibm.com>
