Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264050AbTE3XDA (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 May 2003 19:03:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264052AbTE3XDA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 May 2003 19:03:00 -0400
Received: from air-2.osdl.org ([65.172.181.6]:45800 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264050AbTE3XC6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 May 2003 19:02:58 -0400
Subject: Re: [2.5.70] drivers/video/matrox/* -- Any work-in-progress?
From: Andy Pfiffer <andyp@osdl.org>
To: "Randy.Dunlap" <rddunlap@osdl.org>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20030529095424.3a7d0d6f.rddunlap@osdl.org>
References: <1054226710.17508.16.camel@andyp.pdx.osdl.net>
	 <20030529095424.3a7d0d6f.rddunlap@osdl.org>
Content-Type: text/plain
Organization: 
Message-Id: <1054336543.1208.1.camel@andyp.pdx.osdl.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 30 May 2003 16:15:43 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2003-05-29 at 09:54, Randy.Dunlap wrote:
> On 29 May 2003 09:45:10 -0700 Andy Pfiffer <andyp@osdl.org> wrote:
> 
> | I'm going through a long list of compile-time warnings for 2.5.70, and I
> | see a few from drivers/video/matrox/* .
> | 
> | Does someone have any work-in-progress patches that I should look at
> | before I dive in?

> Petr posted this yesterday:
> ftp://platan.vc.cvut.cz/pub/linux/matrox-latest/mga-stripdown-2.5.70.gz
> 
>                                                     Petr Vandrovec

FYI: That patch applied cleanly for me and is running fine on my Matrox
G400.

Andy



