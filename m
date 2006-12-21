Return-Path: <linux-kernel-owner+w=401wt.eu-S1423042AbWLUTOs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423042AbWLUTOs (ORCPT <rfc822;w@1wt.eu>);
	Thu, 21 Dec 2006 14:14:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423040AbWLUTOs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Dec 2006 14:14:48 -0500
Received: from agminet01.oracle.com ([141.146.126.228]:13130 "EHLO
	agminet01.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1423037AbWLUTOp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Dec 2006 14:14:45 -0500
X-Greylist: delayed 484 seconds by postgrey-1.27 at vger.kernel.org; Thu, 21 Dec 2006 14:14:45 EST
Date: Thu, 21 Dec 2006 11:14:22 -0800
From: Randy Dunlap <randy.dunlap@oracle.com>
To: Eric Sandeen <sandeen@redhat.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       ext4 development <linux-ext4@vger.kernel.org>
Subject: Re: [PATCH] ext2: skip pages past number of blocks in
 ext2_find_entry
Message-Id: <20061221111422.38c58e5f.randy.dunlap@oracle.com>
In-Reply-To: <458ADC45.3050308@redhat.com>
References: <458AD954.7020904@redhat.com>
	<20061221110549.bf336c02.randy.dunlap@oracle.com>
	<458ADC45.3050308@redhat.com>
Organization: Oracle Linux Eng.
X-Mailer: Sylpheed version 2.2.9 (GTK+ 2.8.10; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Whitelist: TRUE
X-Whitelist: TRUE
X-Brightmail-Tracker: AAAAAQAAAAI=
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 21 Dec 2006 13:11:01 -0600 Eric Sandeen wrote:

> Randy Dunlap wrote:
> 
> > Please don't hide the goto; un-indent 1 tab stop.
> Whoops, thanks Randy - it wasn't intentional. :)

Yeah, I didn't think it was.  Sorry if it sounded like that.

---
~Randy
