Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292351AbSBUMCM>; Thu, 21 Feb 2002 07:02:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292348AbSBUMCC>; Thu, 21 Feb 2002 07:02:02 -0500
Received: from ns.suse.de ([213.95.15.193]:23820 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S292351AbSBUMBs>;
	Thu, 21 Feb 2002 07:01:48 -0500
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org, ssharma@us.ibm.com
Subject: Re: socket API extensions workgroup at OpenGroup needs HELP
In-Reply-To: <200202202257.g1KMv4c04306@devserv.devel.redhat.com.suse.lists.linux.kernel> <E16dgPr-000595-00@the-village.bc.nu.suse.lists.linux.kernel>
From: Andi Kleen <ak@suse.de>
Date: 21 Feb 2002 13:01:45 +0100
In-Reply-To: Alan Cox's message of "21 Feb 2002 00:33:21 +0100"
Message-ID: <p73eljfkpqu.fsf@oldwotan.suse.de>
X-Mailer: Gnus v5.7/Emacs 20.6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox <alan@lxorguk.ukuu.org.uk> writes:

> In fact I have a submission for what is needed in API changes. Its a blank
> piece of paper right now. 

Standardizing the linux asynchronous socket error notifications (MSG_ERRQUEUE,
sock_extended_err) would be nice. I guess they could be useful for other
OS too.

-Andi
