Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265263AbUFRTtf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265263AbUFRTtf (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Jun 2004 15:49:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266741AbUFRTsn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Jun 2004 15:48:43 -0400
Received: from mx1.redhat.com ([66.187.233.31]:47788 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S266758AbUFRTrS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Jun 2004 15:47:18 -0400
Date: Fri, 18 Jun 2004 12:47:16 -0700
From: Pete Zaitcev <zaitcev@redhat.com>
To: arjanv@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: Stop the Linux kernel madness
Message-Id: <20040618124716.183669f8@lembas.zaitcev.lan>
In-Reply-To: <mailman.1087541100.18231.linux-kernel2news@redhat.com>
References: <40D232AD.4020708@opensound.com>
	<mailman.1087541100.18231.linux-kernel2news@redhat.com>
Organization: Red Hat, Inc.
X-Mailer: Sylpheed version 0.9.11claws (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 18 Jun 2004 08:40:15 +0200
Arjan van de Ven <arjanv@redhat.com> wrote:

> On Fri, 2004-06-18 at 02:09, 4Front Technologies wrote:

> > I am writing this message to bring a huge problem to light. SuSE has been systematically
> > forking the linux kernel and shipping all kinds of modifications and still call their
> > kernels 2.6.5 (for example).
> 
> internal kernel apis change and are fair game. As a RH kernel maintainer
> I can guarantee you that you will suffer too from internal kernel
> changes in RH/Fedora kernels. Or from changes within the 2.6.x series.
> Linux needs such changes to allow faster and cleaner development.

Arjan, I agree with what you're saying, but it looks to me that the 4front
guy was complaining about the lack of meaningful EXTRAVERSION. Hard to say
for sure when he's raving though...

-- Pete
