Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267209AbUHIVIE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267209AbUHIVIE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Aug 2004 17:08:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267226AbUHIVID
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Aug 2004 17:08:03 -0400
Received: from demon.dataflame.co.uk ([216.127.70.18]:42423 "EHLO
	demon.dataflame.co.uk") by vger.kernel.org with ESMTP
	id S267209AbUHIVIB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Aug 2004 17:08:01 -0400
Message-ID: <4117E68A.4090701@future-ericsoft.com>
Date: Mon, 09 Aug 2004 17:03:06 -0400
From: Eric Masson <cool_kid@future-ericsoft.com>
User-Agent: Mozilla Thunderbird 0.7.1 (X11/20040626)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Fork and Exec a process within the kernel
X-Enigmail-Version: 0.84.2.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

I know it's not the best approach to the problem I'm attempting to 
solve, but I'm attempting to fork a thread and exec a process from 
inside the kernel.   I tried creating a kernel thread and attempted to 
exec from there.  I actually make it into my child thread, but the exec 
doesn't appear to do anything.  Any ideas how to do this.

Eric
