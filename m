Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932557AbWEQN4D@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932557AbWEQN4D (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 May 2006 09:56:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932558AbWEQN4D
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 May 2006 09:56:03 -0400
Received: from ns1.suse.de ([195.135.220.2]:53728 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S932557AbWEQN4B (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 May 2006 09:56:01 -0400
To: Ganesan Rajagopal <rganesan@debian.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Van Jacobson Channels - Earlier Work
References: <xkvhves495x9.fsf@grajagop-lnx.cisco.com>
From: Andi Kleen <ak@suse.de>
Date: 17 May 2006 15:55:59 +0200
In-Reply-To: <xkvhves495x9.fsf@grajagop-lnx.cisco.com>
Message-ID: <p737j4k4uxc.fsf@bragg.suse.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ganesan Rajagopal <rganesan@debian.org> writes:

> Hi,
> 
> A colleague at work pointed me to a 10 year old paper OSDI paper called Lazy
> Receiver Processing (See http://www.cs.rice.edu/CS/Systems/LRP/). The work
> appears similar to what Van Jacobson is proposing in his paper.

Linux has been implementing user context UDP/TCP (which is afaik the main core
feature of LRP) for many years now. netchannels has much more ideas though.

-Andi
