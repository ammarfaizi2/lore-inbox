Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932160AbWEPRTR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932160AbWEPRTR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 May 2006 13:19:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932162AbWEPRTR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 May 2006 13:19:17 -0400
Received: from EXCHG2003.microtech-ks.com ([24.124.14.122]:42905 "EHLO
	EXCHG2003.microtech-ks.com") by vger.kernel.org with ESMTP
	id S932160AbWEPRTR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 May 2006 13:19:17 -0400
Message-ID: <446A0996.50709@atipa.com>
Date: Tue, 16 May 2006 12:19:18 -0500
From: Roger Heflin <rheflin@atipa.com>
User-Agent: Thunderbird 1.5 (X11/20060313)
MIME-Version: 1.0
To: Linux-Kernel <linux-kernel@vger.kernel.org>, openib-general@openib.org
Subject: Heads-up for anyone using certain thunderbird message filter features
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 16 May 2006 17:10:51.0873 (UTC) FILETIME=[AF445510:01C6790B]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Off topic - but probably very important to people using
thunderbird as an email client.

I am using certain thunderbird message filter features - mainly
move to folder and then delete from pop server (this is done
as a single step).

I am on 2 mailing lists that received the same patch set, of the
54 patches emails, 15 patches when to one folder (kernel), 41
patches when to the other folder (openib), and 3 went to both.

So anyone using this should watch as the filter does act odd, I suspect
that it may be that since the message id is the same that, that may be
what it is using to delete the message and may cause it to get both
messages, the emails that I got both copies of were delayed by quote
a bit and very likely came in on different email downloads, so
the other email were not there to delete.

                               Roger
