Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261162AbVCGNqJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261162AbVCGNqJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Mar 2005 08:46:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261165AbVCGNqJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Mar 2005 08:46:09 -0500
Received: from rproxy.gmail.com ([64.233.170.199]:60207 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261162AbVCGNp7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Mar 2005 08:45:59 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=CP/xU+iQN25SeEtn/aQrXjU+Raej+sVZdelYy5u3Azb8fL1H9pQ6NG5GrWElkFvtlPyr331pF5mBFPmpZX+cU4IEqyw1Bj1MKhiktdyCasic2dkxdXJox1hmjKzlc/jU2+CPO13aS47bX1IgnTor+hhPc66XRo3dhxY5bIQjBCI=
Message-ID: <6f6293f10503070545f07cdc1@mail.gmail.com>
Date: Mon, 7 Mar 2005 14:45:55 +0100
From: Felipe Alfaro Solana <felipe.alfaro@gmail.com>
Reply-To: Felipe Alfaro Solana <felipe.alfaro@gmail.com>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Subject: Re: [patch] nicksched for 2.6.11
Cc: Prakash Punnoor <prakashp@arcor.de>,
       linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <422BEE83.7020607@yahoo.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <4225A020.5060001@yahoo.com.au> <42299D31.7020901@arcor.de>
	 <422BEE83.7020607@yahoo.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 07 Mar 2005 17:02:43 +1100, Nick Piggin <nickpiggin@yahoo.com.au> wrote:
> Yes it is. I have a hack in there that automatically renices any
> binary starting with 'XF' to -10 for people who forget. So this
> includes XFree86, though maybe it doesn't get the x.org server?

X.org's X server binary is called "Xorg", though sometimes it's called
"X" (a symbolic link to Xorg).
