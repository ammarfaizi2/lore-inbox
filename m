Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263997AbSJ3Fzo>; Wed, 30 Oct 2002 00:55:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264010AbSJ3Fzo>; Wed, 30 Oct 2002 00:55:44 -0500
Received: from x101-201-88-dhcp.reshalls.umn.edu ([128.101.201.88]:55425 "EHLO
	arashi.yi.org") by vger.kernel.org with ESMTP id <S263997AbSJ3Fzn>;
	Wed, 30 Oct 2002 00:55:43 -0500
Date: Wed, 30 Oct 2002 00:02:07 -0600
From: Matt Reppert <arashi@arashi.yi.org>
To: ebiederm@xmission.com (Eric W. Biederman)
Cc: linux-kernel@vger.kernel.org
Subject: Re: Q: 2.5.45 there and gone again?
Message-Id: <20021030000207.2a52b1e7.arashi@arashi.yi.org>
In-Reply-To: <m14rb4iik9.fsf@frodo.biederman.org>
References: <m14rb4iik9.fsf@frodo.biederman.org>
Organization: Yomerashi
X-Mailer: Sylpheed version 0.8.5 (GTK+ 1.2.10; i686-pc-linux-gnu)
X-message-flag: : This mail sent from host minerva, please respond.
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 29 Oct 2002 22:47:50 -0700
ebiederm@xmission.com (Eric W. Biederman) wrote:

> 
> I looked at kernel.org a little while ago, and 2.5.45 was out.
> And now looking again 2.5.45 has disappeared.
> zeus-pub.kernel.org acting as the finger sever also said it
> was out, and then it wasn't.
> 
> Does any one have a clue what is going on?

Yes. Linus accidentally ran the release scripts. 2.5.45 doesn't
really exist yet.

See here: http://marc.theaimsgroup.com/?l=linux-kernel&m=103595086131620&w=2
