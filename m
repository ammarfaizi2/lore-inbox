Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265034AbUEYSSh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265034AbUEYSSh (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 May 2004 14:18:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265032AbUEYSQM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 May 2004 14:16:12 -0400
Received: from web13902.mail.yahoo.com ([216.136.175.28]:52260 "HELO
	web13902.mail.yahoo.com") by vger.kernel.org with SMTP
	id S265022AbUEYSPO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 May 2004 14:15:14 -0400
Message-ID: <20040525181510.68862.qmail@web13902.mail.yahoo.com>
X-RocketYMMF: knobi.rm
Date: Tue, 25 May 2004 11:15:10 -0700 (PDT)
From: Martin Knoblauch <knobi@knobisoft.de>
Reply-To: knobi@knobisoft.de
Subject: Re: Multicast problems between 2.4.20 and 2.4.21?
To: "David S. Miller" <davem@redhat.com>
Cc: flind@haystack.mit.edu, linux-kernel@vger.kernel.org
In-Reply-To: <20040525103843.0c764c47.davem@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--- "David S. Miller" <davem@redhat.com> wrote:
> 
> You don't need a patch to force IGMPv2, there is a sysctl
> available now in 2.4.x for this purpose.
> 
> 
David,

  what is the name of the sysctl, and when was it added to 2.4? What
about 2.6.x?

Thanks
Martin

=====
------------------------------------------------------
Martin Knoblauch
email: k n o b i AT knobisoft DOT de
www:   http://www.knobisoft.de
