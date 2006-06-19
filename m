Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964874AbWFSUFl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964874AbWFSUFl (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Jun 2006 16:05:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964879AbWFSUFl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Jun 2006 16:05:41 -0400
Received: from nf-out-0910.google.com ([64.233.182.190]:43625 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S964874AbWFSUFk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Jun 2006 16:05:40 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=srjlVBYzdyMSjfU8je8fmB7LCfj4EKDKWGhRFjgx7dwB5v66MOKFmokcTlhrnfbHlJr+xXe2WTL2TYQb/rC/9LiK7dcQnw7OFXqxK8y844vU81/qMS8zacd51CZZlV+tdVeVwnucxtbKRKa6/XhYglvIRsOwO2iqA3Aegol0uwk=
Message-ID: <5bdc1c8b0606191305g3ed4a31j651eb11dcc5dce76@mail.gmail.com>
Date: Mon, 19 Jun 2006 13:05:39 -0700
From: "Mark Knecht" <markknecht@gmail.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: AMD64/2.6.17-rt1 running nicely
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ingo, Thomas, Steve and all others,
   Just checking in to say that 2.6.17-rt1 is up and running here on
my AMD64 machine on the first try. It's been running for about an
hour. No problems so far. No messages in dmesg. Everything looks fine
so far.

   It's probably my imagination but it seems that Jack is using less
CPU. I'm normally used to seeing 2-3%. With this kernel QJackCtl is
reporting less than 1%. Is that real?

   Great work all! Thanks for all the help.

Cheers,
Mark
