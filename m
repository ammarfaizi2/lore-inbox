Return-Path: <linux-kernel-owner+willy=40w.ods.org-S936694AbWLCL6m@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S936694AbWLCL6m (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Dec 2006 06:58:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S936696AbWLCL6l
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Dec 2006 06:58:41 -0500
Received: from mail.syneticon.net ([213.239.212.131]:33478 "EHLO
	mail2.syneticon.net") by vger.kernel.org with ESMTP id S936694AbWLCL6l
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Dec 2006 06:58:41 -0500
Message-ID: <4572BBE0.4010801@wpkg.org>
Date: Sun, 03 Dec 2006 12:58:24 +0100
From: Tomasz Chmielewski <mangoo@wpkg.org>
User-Agent: Thunderbird 1.5.0.8 (X11/20061128)
MIME-Version: 1.0
To: Andreas Schwab <schwab@suse.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: why can't I remove a kernel module (or: what uses a given module)?
References: <4572B30F.9020605@wpkg.org> <jewt592oxf.fsf@sykes.suse.de>
In-Reply-To: <jewt592oxf.fsf@sykes.suse.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andreas Schwab wrote:
> Tomasz Chmielewski <mangoo@wpkg.org> writes:
> 
>> What was using the module in the first scenario (I couldn't remove the
>> module)?
> 
> Check lsmod for modules depending on this one.

You mean the "Used by" column? No, it's not used by any other module 
according to lsmod output.

Any other methods of checking what uses /dev/sda*?


-- 
Tomasz Chmielewski
http://wpkg.org
