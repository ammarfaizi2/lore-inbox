Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965227AbWGKG5w@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965227AbWGKG5w (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jul 2006 02:57:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965046AbWGKG5w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jul 2006 02:57:52 -0400
Received: from ns1.suse.de ([195.135.220.2]:43699 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S965037AbWGKG5v convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jul 2006 02:57:51 -0400
From: Andi Kleen <ak@suse.de>
To: Fernando Luis =?utf-8?q?V=C3=A1zquez_Cao?= 
	<fernando@oss.ntt.co.jp>
Subject: Re: [PATCH 0/4] stack overflow safe kdump (2.6.18-rc1-i386) try#2
Date: Tue, 11 Jul 2006 08:59:17 +0200
User-Agent: KMail/1.9.1
Cc: vgoyal@in.ibm.com, "Eric W. Biederman" <ebiederm@xmission.com>,
       akpm@osdl.org, James.Bottomley@steeleye.com,
       linux-kernel@vger.kernel.org, fastboot@lists.osdl.org
References: <1152597884.2414.53.camel@localhost.localdomain>
In-Reply-To: <1152597884.2414.53.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200607110859.17454.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 11 July 2006 08:04, Fernando Luis Vázquez Cao wrote:
> Hi,
>
> I tried to incorporate all the ideas received after the previous post
> (thank you!). In particular I hope the new code is handling the Voyager
> case properly.

Looks all reasonable to me.

-Andi


