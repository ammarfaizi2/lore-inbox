Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030203AbWJJQtd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030203AbWJJQtd (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Oct 2006 12:49:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030206AbWJJQtc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Oct 2006 12:49:32 -0400
Received: from mx1.redhat.com ([66.187.233.31]:52380 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1030203AbWJJQtb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Oct 2006 12:49:31 -0400
Message-ID: <452BCF13.6070200@redhat.com>
Date: Tue, 10 Oct 2006 11:49:23 -0500
From: Eric Sandeen <esandeen@redhat.com>
User-Agent: Thunderbird 1.5.0.7 (X11/20060913)
MIME-Version: 1.0
To: Badari Pulavarty <pbadari@us.ibm.com>
CC: Jan Kara <jack@suse.cz>, akpm@osdl.org, ext4 <linux-ext4@vger.kernel.org>,
       lkml <linux-kernel@vger.kernel.org>, Dave Jones <davej@redhat.com>
Subject: Re: ext3 fsx failures on 2.6.19-rc1
References: <1160436605.17103.27.camel@dyn9047017100.beaverton.ibm.com>	 <20061010123059.GJ23622@atrey.karlin.mff.cuni.cz> <1160498487.17103.30.camel@dyn9047017100.beaverton.ibm.com>
In-Reply-To: <1160498487.17103.30.camel@dyn9047017100.beaverton.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Badari Pulavarty wrote:
						
> fsx got a segmentation fault and died. These are the messages in the
> dmesg.

I've never seen fsx die that way before... can you get a coredump to see
where it was at?

-Eric
