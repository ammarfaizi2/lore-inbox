Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750975AbWEQAES@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750975AbWEQAES (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 May 2006 20:04:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750988AbWEQAES
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 May 2006 20:04:18 -0400
Received: from mcr-smtp-002.bulldogdsl.com ([212.158.248.8]:22020 "EHLO
	mcr-smtp-002.bulldogdsl.com") by vger.kernel.org with ESMTP
	id S1750975AbWEQAER convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 May 2006 20:04:17 -0400
X-Spam-Abuse: Please report all spam/abuse matters to abuse@bulldogdsl.com
From: Alistair John Strachan <s0348365@sms.ed.ac.uk>
To: =?iso-8859-1?q?M=E5ns_Rullg=E5rd?= <mru@inprovide.com>
Subject: Re: replacing X Window System !
Date: Wed, 17 May 2006 00:23:55 +0100
User-Agent: KMail/1.9.1
Cc: linux-kernel@vger.kernel.org
References: <20060516214148.14432.qmail@web26611.mail.ukl.yahoo.com> <yw1xbqtx1vlb.fsf@agrajag.inprovide.com>
In-Reply-To: <yw1xbqtx1vlb.fsf@agrajag.inprovide.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200605170023.55792.s0348365@sms.ed.ac.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 16 May 2006 22:57, Måns Rullgård wrote:
> linux cbon <linuxcbon@yahoo.fr> writes:
[snip]
>
> > it cannot do VNC, etc.
>
> Most programs can't do VNC.

I must also note that this is wrong. Many VNC implementations come with the 
Xvnc server (a drop-in replacement for X, headless) and there's the xf4vnc 
project which provides a few pseudo-devices for a regular X session and hooks 
into the video updates (which are then sent via VNC as well as directly to 
your video hardware).

-- 
Cheers,
Alistair.

Third year Computer Science undergraduate.
1F2 55 South Clerk Street, Edinburgh, UK.
