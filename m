Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264061AbTDJOuj (for <rfc822;willy@w.ods.org>); Thu, 10 Apr 2003 10:50:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264062AbTDJOuj (for <rfc822;linux-kernel-outgoing>);
	Thu, 10 Apr 2003 10:50:39 -0400
Received: from pointblue.com.pl ([62.89.73.6]:28676 "EHLO pointblue.com.pl")
	by vger.kernel.org with ESMTP id S264061AbTDJOui (for <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Apr 2003 10:50:38 -0400
Subject: Re: ATAPI cdrecord issue 2.5.67
From: Grzegorz Jaskiewicz <gj@pointblue.com.pl>
To: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1049986391.599.6.camel@teapot.felipe-alfaro.com>
References: <1049983308.888.5.camel@gregs>  <1049984188.887.11.camel@gregs>
	 <1049986391.599.6.camel@teapot.felipe-alfaro.com>
Content-Type: text/plain
Organization: K4 Labs
Message-Id: <1049985788.888.13.camel@gregs>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 
Date: 10 Apr 2003 15:43:08 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2003-04-10 at 15:53, Felipe Alfaro Solana wrote:
> On Thu, 2003-04-10 at 16:16, Grzegorz Jaskiewicz wrote:
> > it works fine if i will do dev=/dev/hdd
> > but still output of cdrecord is supprising to me.
> > Also after inserting ide-scsi /dev/scd* nor /dev/sg* apears.
> 
> ide-scsi is still broken in 2.5... don't know if it's gonna get fixed or
> deprecated as ATAPI support is working.
Well, that is allright. Just wondering about this -scanbus message :-)

-- 
Grzegorz Jaskiewicz <gj@pointblue.com.pl>
K4 Labs

