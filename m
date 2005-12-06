Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964941AbVLFK24@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964941AbVLFK24 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Dec 2005 05:28:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932548AbVLFK24
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Dec 2005 05:28:56 -0500
Received: from mail.ispwest.com ([216.52.245.18]:15886 "EHLO
	ispwest-email1.mdeinc.com") by vger.kernel.org with ESMTP
	id S932547AbVLFK2z convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Dec 2005 05:28:55 -0500
X-Modus-BlackList: 216.52.245.25=OK;kjak@ispwest.com=OK
X-Modus-Trusted: 216.52.245.25=YES
Message-ID: <b5637f768861402a9e5147ef8b183de4.kjak@ispwest.com>
X-EM-APIVersion: 2, 0, 1, 0
X-Priority: 3 (Normal)
Reply-To: "Kris Katterjohn" <kjak@users.sourceforge.net>
From: "Kris Katterjohn" <kjak@ispwest.com>
To: davem@davemloft.net
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Socket filter instruction limit validation
Date: Tue, 6 Dec 2005 02:28:52 -0800
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: David S. Miller
Sent: 12/6/2005 2:20:21 AM

> From: "Kris Katterjohn" <kjak@ispwest.com>
> Date: Tue, 6 Dec 2005 02:10:49 -0800
> 
> > This patch checks to make sure that the number of instructions doesn't surpass
> > BPF_MAXINSNS in sk_chk_filter().
> > 
> > Signed-off-by: Kris Katterjohn <kjak@users.sourceforge.net>
> 
> How about posting networking patches to netdev@vger.kernel.org for
> discussion, and the CC:'ing the networking maintainer (me)?
> 
> Thanks.

Sorry, I'm still new to this kernel development stuff. :) Should I send it there
now, or did you, or is it accepted, or...?

Kris

