Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265273AbUAYUgR (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Jan 2004 15:36:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265276AbUAYUgR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Jan 2004 15:36:17 -0500
Received: from d213-103-156-147.cust.tele2.ch ([213.103.156.147]:21057 "EHLO
	kameha") by vger.kernel.org with ESMTP id S265273AbUAYUgQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Jan 2004 15:36:16 -0500
Message-ID: <401428CB.3030308@freesurf.ch>
Date: Sun, 25 Jan 2004 21:36:27 +0100
From: Marc Mongenet <Marc.Mongenet@freesurf.ch>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040113
X-Accept-Language: fr, en
MIME-Version: 1.0
To: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.4.25pre7 - cannot mount 128MB vfat fs on Minolta camera
References: <4013D155.3080900@freesurf.ch>	<87y8rw2eyy.fsf@devron.myhome.or.jp> <40140221.40901@freesurf.ch> <87isiz3luw.fsf@devron.myhome.or.jp>
In-Reply-To: <87isiz3luw.fsf@devron.myhome.or.jp>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

OGAWA Hirofumi wrote:
> Hi,
> 
> Is this known problem? Any idea?
> 
> Thanks.
> 
> Marc Mongenet <Marc.Mongenet@freesurf.ch> writes:

Thanks for your help.
Note that the sd_mod reload trick from Måns Rullgård works (is it safe?).
The scsiadd trick from Philip Dodd works when the CD-ROM is not attached.
Sorry for not replying directly, I am not subscribed to lkml.

Marc Mongenet
