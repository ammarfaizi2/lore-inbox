Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268203AbUJDUDq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268203AbUJDUDq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Oct 2004 16:03:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268260AbUJDUDp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Oct 2004 16:03:45 -0400
Received: from pfepa.post.tele.dk ([195.41.46.235]:37686 "EHLO
	pfepa.post.tele.dk") by vger.kernel.org with ESMTP id S268203AbUJDUDg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Oct 2004 16:03:36 -0400
Date: Tue, 5 Oct 2004 00:04:00 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>, sam@ravnborg.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Make gcc -align options .config-settable
Message-ID: <20041004220400.GA16028@mars.ravnborg.org>
Mail-Followup-To: Andrew Morton <akpm@osdl.org>,
	Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>,
	sam@ravnborg.org, linux-kernel@vger.kernel.org
References: <200410012226.23565.vda@port.imtp.ilyichevsk.odessa.ua> <20041001151751.3917d9d5.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041001151751.3917d9d5.akpm@osdl.org>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 01, 2004 at 03:17:51PM -0700, Andrew Morton wrote:
> Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua> wrote:
> >
> > With all alignment options set to 1 (minimum alignment),
> > I've got 5% smaller vmlinux compared to one built with
> > default code alignment.
> > 
> 
> Sam, can you process this one?

I will do so in a week or so.
Travelling (and busy) these days.

	Sam
