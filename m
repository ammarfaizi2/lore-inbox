Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264059AbTDJOln (for <rfc822;willy@w.ods.org>); Thu, 10 Apr 2003 10:41:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264062AbTDJOln (for <rfc822;linux-kernel-outgoing>);
	Thu, 10 Apr 2003 10:41:43 -0400
Received: from 205-158-62-136.outblaze.com ([205.158.62.136]:18358 "HELO
	fs5-4.us4.outblaze.com") by vger.kernel.org with SMTP
	id S264059AbTDJOlm (for <rfc822;linux-kernel@vger.kernel.org>); Thu, 10 Apr 2003 10:41:42 -0400
Subject: Re: ATAPI cdrecord issue 2.5.67
From: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
To: Grzegorz Jaskiewicz <gj@pointblue.com.pl>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1049984188.887.11.camel@gregs>
References: <1049983308.888.5.camel@gregs>  <1049984188.887.11.camel@gregs>
Content-Type: text/plain
Organization: 
Message-Id: <1049986391.599.6.camel@teapot.felipe-alfaro.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.3 (1.2.3-1) 
Date: 10 Apr 2003 16:53:11 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2003-04-10 at 16:16, Grzegorz Jaskiewicz wrote:
> it works fine if i will do dev=/dev/hdd
> but still output of cdrecord is supprising to me.
> Also after inserting ide-scsi /dev/scd* nor /dev/sg* apears.

ide-scsi is still broken in 2.5... don't know if it's gonna get fixed or
deprecated as ATAPI support is working.

-- 
Please AVOID sending me WORD, EXCEL or POWERPOINT attachments.
See http://www.fsf.org/philosophy/no-word-attachments.html
Linux Registered User #287198

