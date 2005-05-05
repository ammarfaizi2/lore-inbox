Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261838AbVEECg7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261838AbVEECg7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 May 2005 22:36:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261849AbVEECg7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 May 2005 22:36:59 -0400
Received: from mail-in-01.arcor-online.net ([151.189.21.41]:38633 "EHLO
	mail-in-01.arcor-online.net") by vger.kernel.org with ESMTP
	id S261838AbVEECgl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 May 2005 22:36:41 -0400
From: "Bodo Eggert <harvested.in.lkml@posting.7eggert.dyndns.org>" 
	<7eggert@gmx.de>
Subject: Re: [RFC][PATCH] update SubmittingPatches to clarify attachment policy
To: dtor_core@ameritech.net, linux-kernel@vger.kernel.org,
       Dave Hansen <haveblue@us.ibm.com>
Reply-To: 7eggert@gmx.de
Date: Thu, 05 May 2005 04:36:35 +0200
References: <40vxU-1a1-25@gated-at.bofh.it> <40vRd-1os-1@gated-at.bofh.it>
User-Agent: KNode/0.7.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
Message-Id: <E1DTWE8-0005FZ-0z@be1.7eggert.dyndns.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dmitry Torokhov <dmitry.torokhov@gmail.com> wrote:
> On 5/4/05, Dave Hansen <haveblue@us.ibm.com> wrote:

>> I think the general opinion of posting patches as attachments
>> has changed over the last few years.  Mailers have been getting
>> a lot better at handling them, even quoting non-message-body
>> plain/text attachments in replies.
> 
> What, Linus updated his pine?????

Pine is usurally better for handling patches than other mailers.
In pine, you can save a message into a mbox using very few keystrokes,
and if the patches are not encoded, patch can parse them from there.



BTW: I wrote a tool for handling MIME mails. Originally it was intended to
catch spam in procmail, but it can safe the individual parts into seperate
files, too. Maybe this is usefull:

http://7eggert.dyndns.org/~7eggert/hp/l/spam+mail/mime-analyzer/

(You'd use "cd $destdir && formail < $mbox -s mail-analyzer -copy_all -")
-- 
According to my calculations the problem doesn't exist. 

