Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261364AbSKTPst>; Wed, 20 Nov 2002 10:48:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261365AbSKTPst>; Wed, 20 Nov 2002 10:48:49 -0500
Received: from pc1-cwma1-5-cust42.swa.cable.ntl.com ([80.5.120.42]:12162 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S261364AbSKTPss> convert rfc822-to-8bit; Wed, 20 Nov 2002 10:48:48 -0500
Subject: Re: PROBLEM: kernel oopsing in ftp.es.debian.org.
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: David =?ISO-8859-1?Q?Mart=EDnez?= Moreno <ender@debian.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <200211201648.58812.ender@debian.org>
References: <200211201226.18015.ender@debian.org>
	<1037800230.3241.4.camel@irongate.swansea.linux.org.uk> 
	<200211201648.58812.ender@debian.org>
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 20 Nov 2002 16:24:24 +0000
Message-Id: <1037809464.3702.45.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2002-11-20 at 15:48, David Martínez Moreno wrote:
> 	The last kernel that it ran stably I think that was 2.4.19-pre10. I can 
> reboot with this kernel, because the machine has hung again. One more reboot 
> doesn't mind. :-(

Stick the last stable kernel on it and see if becomes stable again. My
first guess is you've developed a hardware problem, going back to the
old kernel will eliminate that doubt

