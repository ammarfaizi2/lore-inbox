Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261939AbUEFJsn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261939AbUEFJsn (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 May 2004 05:48:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261947AbUEFJsm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 May 2004 05:48:42 -0400
Received: from smtp-out5.blueyonder.co.uk ([195.188.213.8]:9564 "EHLO
	smtp-out5.blueyonder.co.uk") by vger.kernel.org with ESMTP
	id S261939AbUEFJsl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 May 2004 05:48:41 -0400
Message-ID: <409A09F7.4080809@blueyonder.co.uk>
Date: Thu, 06 May 2004 10:48:39 +0100
From: Sid Boyce <sboyce@blueyonder.co.uk>
Reply-To: sboyce@blueyonder.co.uk
User-Agent: Mozilla Thunderbird 0.6 (X11/20040502)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: 2.6.6-rc3-mm2 (4KSTACK)
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 06 May 2004 09:48:43.0216 (UTC) FILETIME=[51458500:01C4334F]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Not only does it not work, I've cratered two reiserfs installs using 
4KSTACKS and the nvidia driver, once when I didn't know about the 
problem and once when I forgot to reverse the patch. I now always check 
my .config before I start the build. Nvidia like most outfits don't 
react that swiftly to kernel changes.
Regards
Sid.

-- 
Sid Boyce .... Hamradio G3VBV and keen Flyer
Linux Only Shop.

