Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030261AbWEKPU2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030261AbWEKPU2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 May 2006 11:20:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030247AbWEKPU2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 May 2006 11:20:28 -0400
Received: from [81.2.110.250] ([81.2.110.250]:46546 "EHLO lxorguk.ukuu.org.uk")
	by vger.kernel.org with ESMTP id S1030261AbWEKPU2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 May 2006 11:20:28 -0400
Subject: Re: SecurityFocus Article
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Ed White <ed.white@libero.it>
Cc: ML <linux-kernel@vger.kernel.org>
In-Reply-To: <20060511143440.23517.qmail@securityfocus.com>
References: <20060511143440.23517.qmail@securityfocus.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Thu, 11 May 2006 16:32:38 +0100
Message-Id: <1147361558.26130.30.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-4.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Iau, 2006-05-11 at 14:34 +0000, Ed White wrote:
> The big problem is that the attack is possible thanks to the way X
> Windows is designed

Where did you get that idea.

What it essentially says is "if you can hack the machine enough to get
the ability to issue raw i/o accesses you can get any other power you
want". Thats always been true. Using SMM to do this seems awfully hard
work.

Alan

