Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262004AbTJTJsv (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Oct 2003 05:48:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262470AbTJTJsv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Oct 2003 05:48:51 -0400
Received: from as1-2-5.han.s.bonet.se ([194.236.155.59]:30477 "EHLO
	palpatine.hardeman.nu") by vger.kernel.org with ESMTP
	id S262004AbTJTJsu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Oct 2003 05:48:50 -0400
Message-ID: <3F93AF7F.9030206@2gen.com>
Date: Mon, 20 Oct 2003 11:48:47 +0200
From: =?ISO-8859-1?Q?David_H=E4rdeman?= <david@2gen.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20031014 Thunderbird/0.3
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: Suspend with 2.6.0-test7-mm1
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Måns Rullgård <mru@users.sf.net> wrote:
> I've seen this, too.  Try "sleep 1; echo -n standby > /sys/power/state".  
> I theory I thought of, is that the system suspends before you have
> time to release the enter key, and the key release triggers a wakeup.

Ok, tried it, doesn't help (exactly the same behaviour)...any more 
suggestions?

Re,
David


