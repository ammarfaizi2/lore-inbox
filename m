Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269876AbUJHAtv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269876AbUJHAtv (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Oct 2004 20:49:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269961AbUJHAqV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Oct 2004 20:46:21 -0400
Received: from viper.oldcity.dca.net ([216.158.38.4]:17330 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S269896AbUJHAha (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Oct 2004 20:37:30 -0400
Subject: Re: UDP recvmsg blocks after select(), 2.6 bug?
From: Lee Revell <rlrevell@joe-job.com>
To: "David S. Miller" <davem@davemloft.net>
Cc: Mark Mielke <mark@mark.mielke.cc>, msipkema@sipkema-digital.com,
       cfriesen@nortelnetworks.com, hzhong@cisco.com, jst1@email.com,
       linux-kernel <linux-kernel@vger.kernel.org>, alan@lxorguk.ukuu.org.uk,
       davem@redhat.com
In-Reply-To: <20041007154722.2a09c4ab.davem@davemloft.net>
References: <00e501c4ac9a$556797d0$b83147ab@amer.cisco.com>
	 <41658C03.6000503@nortelnetworks.com>
	 <015f01c4acbe$cf70dae0$161b14ac@boromir>
	 <4165B9DD.7010603@nortelnetworks.com>
	 <20041007150035.6e9f0e09.davem@davemloft.net>
	 <000901c4acc4$26404450$161b14ac@boromir>
	 <20041007152400.17e8f475.davem@davemloft.net>
	 <20041007224242.GA31430@mark.mielke.cc>
	 <20041007154722.2a09c4ab.davem@davemloft.net>
Content-Type: text/plain
Message-Id: <1097195845.9372.30.camel@krustophenia.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Thu, 07 Oct 2004 20:37:25 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2004-10-07 at 18:47, David S. Miller wrote:
> On Thu, 7 Oct 2004 18:42:42 -0400
> Mark Mielke <mark@mark.mielke.cc> wrote:
> 
> > Sure, it's nice to demand that people
> > upgrade to a later version of Perl. Guess what? It isn't happening. It
> > will be another year or two before we can guarantee people have Perl
> > 5.006 on their system.
> 
> If those people are tepid about upgrading perl, I think it would
> be even less likely that they would upgrade their kernels.

Not true.  If you upgrade the kernel you may incur a little downtime. 
Upgrade perl and you potentially break 1000's of customer CGI scripts.

Lee

