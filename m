Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751306AbWCAWHM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751306AbWCAWHM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Mar 2006 17:07:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751308AbWCAWHM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Mar 2006 17:07:12 -0500
Received: from mx1.redhat.com ([66.187.233.31]:60819 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751306AbWCAWHK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Mar 2006 17:07:10 -0500
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20060301125053.15a68d59.akpm@osdl.org> 
References: <20060301125053.15a68d59.akpm@osdl.org>  <20060220170913.b232dc20.davi.arnaut@gmail.com> <4993.1140431092@warthog.cambridge.redhat.com> <20060218161122.f9d588fb.davi.arnaut@gmail.com> <20060218113602.edc06ce5.davi.arnaut@gmail.com> <3487.1140281089@warthog.cambridge.redhat.com> <5378.1140431896@warthog.cambridge.redhat.com> <4967.1141221980@warthog.cambridge.redhat.com> <20060301121651.8e023c8e.davi.arnaut@gmail.com> 
To: Andrew Morton <akpm@osdl.org>
Cc: Davi Arnaut <davi.arnaut@gmail.com>, dhowells@redhat.com, vsu@altlinux.ru,
       alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] strndup_user (v3), convert (keyctl) 
X-Mailer: MH-E 7.92+cvs; nmh 1.1; GNU Emacs 22.0.50.4
Date: Wed, 01 Mar 2006 22:06:58 +0000
Message-ID: <32401.1141250818@warthog.cambridge.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton <akpm@osdl.org> wrote:

> Which, strndup_user()?
> 
> I guess so - would need to see it again.  But David's
> keys-deal-properly-with-strnlen_user.patch should go first, since it
> kinda-fixes things.

I'm happy to let Davi's latest patches displace mine, as they seem to do
everything I want of them.

I'll test them tomorrow (it's way past time to grab a curry and go home).

David
