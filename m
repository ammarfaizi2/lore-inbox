Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261962AbVFGUJ6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261962AbVFGUJ6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Jun 2005 16:09:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261963AbVFGUJ5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Jun 2005 16:09:57 -0400
Received: from gw.ateles.se ([85.112.166.32]:53174 "EHLO venus.ateles.se")
	by vger.kernel.org with ESMTP id S261962AbVFGUJo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Jun 2005 16:09:44 -0400
Message-ID: <42A5FF09.4040306@ateles.se>
Date: Tue, 07 Jun 2005 22:09:45 +0200
From: Morgan Nilsson <morgan.nilsson@ateles.se>
Organization: Ateles Consulting AB
User-Agent: Mozilla Thunderbird 1.0.2 (Windows/20050317)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: [2.6.11]: Bugs in handle striped LVM volumes ?
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have exact the same problem.

After upgrading to 2.6.11 my striped raid1 lvm2 volumes started to be 
corrupted. No problem with my non striped raid1 lvm2 volumes.

I had to recreate them without striping and read from tape (data loss!).

