Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261546AbTJRLOo (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Oct 2003 07:14:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261539AbTJRLOo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Oct 2003 07:14:44 -0400
Received: from fw.osdl.org ([65.172.181.6]:33159 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261538AbTJRLOn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Oct 2003 07:14:43 -0400
Date: Sat, 18 Oct 2003 04:14:48 -0700
From: Andrew Morton <akpm@osdl.org>
To: Nico Schottelius <nico-kernel@schottelius.org>
Cc: trini@kernel.crashing.org, linux-kernel@vger.kernel.org,
       linux-net@vger.kernel.org
Subject: Re: 3c59x problem with 2.4.6-test[34]
Message-Id: <20031018041448.6362faee.akpm@osdl.org>
In-Reply-To: <20031018122708.GA401@schottelius.org>
References: <20030907212348.GA836@ip68-0-152-218.tc.ph.cox.net>
	<20030929151827.GB862@ip68-0-152-218.tc.ph.cox.net>
	<20031015183505.GA963@ip68-0-152-218.tc.ph.cox.net>
	<20031017235325.GA957@ip68-0-152-218.tc.ph.cox.net>
	<20031018122708.GA401@schottelius.org>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nico Schottelius <nico-kernel@schottelius.org> wrote:
>
> another lspci -vvv where the card works f***cking slow:

There is a description of various diagnostic procedures in
Documentation/networking/vortex.txt.  If you could run through those then
wemight know more.

