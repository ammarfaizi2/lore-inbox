Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264127AbUACVQP (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Jan 2004 16:16:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264137AbUACVQP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Jan 2004 16:16:15 -0500
Received: from c211-28-147-198.thoms1.vic.optusnet.com.au ([211.28.147.198]:12478
	"EHLO mail.kolivas.org") by vger.kernel.org with ESMTP
	id S264127AbUACVQO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Jan 2004 16:16:14 -0500
From: Con Kolivas <kernel@kolivas.org>
To: Soeren Sonnenburg <kernel@nn7.de>
Subject: Re: xterm scrolling speed - scheduling weirdness in 2.6 ?!
Date: Sun, 4 Jan 2004 08:15:54 +1100
User-Agent: KMail/1.5.3
Cc: Mark Hahn <hahn@physics.mcmaster.ca>,
       Linux Kernel <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.44.0401031439060.24942-100000@coffee.psychology.mcmaster.ca> <200401040800.06529.kernel@kolivas.org> <1073164240.9851.319.camel@localhost>
In-Reply-To: <1073164240.9851.319.camel@localhost>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200401040815.54655.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 4 Jan 2004 08:10, Soeren Sonnenburg wrote:
> On Sat, 2004-01-03 at 22:00, Con Kolivas wrote:
> > On Sun, 4 Jan 2004 07:19, Soeren Sonnenburg wrote:
> > > On Sat, 2004-01-03 at 20:40, Mark Hahn wrote:
>
> [it is a bash bug]
> huuhh ? How can this be a bash bug if the output is done by other
> programs like dmesg or find ? however I just tested - this issue happens
> with csh/tcsh too...

The bash bug was waiting on a pipe problem; not just bash alone. I was just 
offering a suggestion. I have no idea what exactly to blame without evidence 
of what's at fault.

Con

