Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262261AbUKQLM1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262261AbUKQLM1 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Nov 2004 06:12:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262202AbUKQLJ6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Nov 2004 06:09:58 -0500
Received: from pop5-1.us4.outblaze.com ([205.158.62.125]:36843 "HELO
	pop5-1.us4.outblaze.com") by vger.kernel.org with SMTP
	id S262261AbUKQLIW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Nov 2004 06:08:22 -0500
Subject: Re: Slab corruption with 2.6.9 + swsusp2.1
From: Nigel Cunningham <ncunningham@linuxmail.org>
Reply-To: ncunningham@linuxmail.org
To: Ake <Ake.Sandgren@hpc2n.umu.se>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20041117110317.GM26723@hpc2n.umu.se>
References: <20041116115917.GN4344@hpc2n.umu.se>
	 <1100635759.4362.4.camel@desktop.cunninghams>
	 <20041117064403.GB26723@hpc2n.umu.se>
	 <1100688279.4040.4.camel@desktop.cunninghams>
	 <20041117110317.GM26723@hpc2n.umu.se>
Content-Type: text/plain
Message-Id: <1100689469.4040.20.camel@desktop.cunninghams>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6-1mdk 
Date: Wed, 17 Nov 2004 22:04:29 +1100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

On Wed, 2004-11-17 at 22:03, Ake wrote:
> On Wed, Nov 17, 2004 at 09:44:40PM +1100, Nigel Cunningham wrote:
> > Had you suspended prior to this? If not, you can rule the suspend code
> > out. If you had, I wouldn't rule it out because I am trying to identify
> > the cause of some occasional slab corruption at the moment. Haven't got
> > it reproducible yet.
> 
> No, it was recently rebooted (4h 20min before) and no suspend.

Okay; it won't be suspend related then. If you want to get a response
from someone else, you might want to repost with a different subject
line.

Regards,

Nigel
-- 
Nigel Cunningham
Pastoral Worker
Christian Reformed Church of Tuggeranong
PO Box 1004, Tuggeranong, ACT 2901

You see, at just the right time, when we were still powerless, Christ
died for the ungodly.		-- Romans 5:6

