Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261426AbSJZQh6>; Sat, 26 Oct 2002 12:37:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261427AbSJZQh6>; Sat, 26 Oct 2002 12:37:58 -0400
Received: from smtp3.texas.rr.com ([24.93.36.231]:37331 "EHLO
	txsmtp03.texas.rr.com") by vger.kernel.org with ESMTP
	id <S261426AbSJZQh5>; Sat, 26 Oct 2002 12:37:57 -0400
Message-ID: <3DBAC65B.4050000@us.ibm.com>
Date: Sat, 26 Oct 2002 11:44:11 -0500
From: Jon Grimm <jgrimm2@us.ibm.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.0.1) Gecko/20020823 Netscape/7.0
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andi Kleen <ak@suse.de>
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.5.44: Still has KVM + Mouse issues
References: <3DB9DA64.E48C8C5B@us.ibm.com.suse.lists.linux.kernel> <p738z0lu2dl.fsf@oldwotan.suse.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks Andi,
	The workaround sounds reasonable.
-jon
Andi Kleen wrote:

> Boot with psmouse_noext, that should fix it. It runs the intellimouse as a 
> plain PS/2 mouse. You lose the additional mouse buttons and the scroll wheel, 
> but they never worked through that KVM anyways.
> 
> -Andi
> 

