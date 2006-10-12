Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750801AbWJLRFH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750801AbWJLRFH (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Oct 2006 13:05:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751424AbWJLRFG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Oct 2006 13:05:06 -0400
Received: from mustang.oldcity.dca.net ([216.158.38.3]:31197 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S1750801AbWJLRFC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Oct 2006 13:05:02 -0400
Subject: Re: Userspace process may be able to DoS kernel
From: Lee Revell <rlrevell@joe-job.com>
To: =?ISO-8859-1?Q?G=FCnther?= Starnberger <gst@sysfrog.org>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <474c7c2f0610120955ma1850b4lf20ac1f826ff4a35@mail.gmail.com>
References: <474c7c2f0610110954y46b68a14q17b88a5e28ffe8d9@mail.gmail.com>
	 <1160668290.24931.31.camel@mindpipe>
	 <474c7c2f0610120955ma1850b4lf20ac1f826ff4a35@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Date: Thu, 12 Oct 2006 13:05:58 -0400
Message-Id: <1160672758.24931.48.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-10-12 at 12:55 -0400, Günther Starnberger wrote:
> On 10/12/06, Lee Revell <rlrevell@joe-job.com> wrote:
> 
> > Do you get the same behavior using the old OSS drivers that you get with
> > ALSA's OSS emulation?
> 
> No - not yet. The problem occurs when I use ALSA directly as well as
> with ALSA's OSS emulation.
> 

Ah, OK, I did not realize that Skype had (FINALLY) released a version
with ALSA support...

> I will check if there is an OSS driver for my soundcard so that I can
> try this out.
> 


