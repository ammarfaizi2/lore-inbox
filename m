Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277146AbRJLBcF>; Thu, 11 Oct 2001 21:32:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277145AbRJLBb4>; Thu, 11 Oct 2001 21:31:56 -0400
Received: from smtp6.mindspring.com ([207.69.200.110]:18979 "EHLO
	smtp6.mindspring.com") by vger.kernel.org with ESMTP
	id <S277143AbRJLBbw>; Thu, 11 Oct 2001 21:31:52 -0400
Subject: Re: Tainted Modules Help Notices
From: Robert Love <rml@tech9.net>
To: David Schwartz <davids@webmaster.com>
Cc: jalvo@mbay.net, linux-kernel@vger.kernel.org
In-Reply-To: <20011012011217.AAA27996@shell.webmaster.com@whenever>
In-Reply-To: <20011012011217.AAA27996@shell.webmaster.com@whenever>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.15.99+cvs.2001.10.05.08.08 (Preview Release)
Date: 11 Oct 2001 21:32:24 -0400
Message-Id: <1002850347.872.95.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2001-10-11 at 21:12, David Schwartz wrote:
> 	Perhaps the best solution is to develop a 'kernel module license' that 
> simply requires that the source code be made available to anyone who wishes 
> to debug for the purpose of debugging. Complying with the terms of the 
> 'kernel module license' would give you module that don't taint the kernel. 

But if we couldn't release the (fixed) source, then what is the point? 
If it is not open source, why should Alan or I or anyone care to debug
it?

What we want is for users to not have a tainted kernel, so we can debug
the problem and release the results.  We are interested in fixing our (=
the open source community's) problems, not others.

	Robert Love

