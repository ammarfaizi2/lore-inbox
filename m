Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265668AbUGEI7w@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265668AbUGEI7w (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Jul 2004 04:59:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265736AbUGEI7w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jul 2004 04:59:52 -0400
Received: from webapps.arcom.com ([194.200.159.168]:46340 "EHLO
	webapps.arcom.com") by vger.kernel.org with ESMTP id S265668AbUGEI7v
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jul 2004 04:59:51 -0400
Message-ID: <40E91885.1000707@arcom.com>
Date: Mon, 05 Jul 2004 09:59:49 +0100
From: David Vrabel <dvrabel@arcom.com>
User-Agent: Mozilla Thunderbird 0.6 (X11/20040605)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Some cleanup patches for: '...lvalues is deprecated'
References: <40E6AC41.4050804@tiscali.be> <20040703205621.GA1640@ucw.cz> <20040705051010.GA24583@nevyn.them.org>
In-Reply-To: <20040705051010.GA24583@nevyn.them.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 05 Jul 2004 09:00:51.0312 (UTC) FILETIME=[9244BF00:01C4626E]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Daniel Jacobowitz wrote:
> 
> Except C does not actually allow incrementing a void pointer, since
> void does not have a size.  You can't do arithmetic on one either.  GNU
> C allows this as an extension.

GCC seems to have a whole bunch of ill thought out extensions like this.

David Vrabel
-- 
David Vrabel, Design Engineer

Arcom, Clifton Road           Tel: +44 (0)1223 411200 ext. 3233
Cambridge CB1 7EA, UK         Web: http://www.arcom.com/
