Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751416AbWBRQpG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751416AbWBRQpG (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Feb 2006 11:45:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751419AbWBRQpG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Feb 2006 11:45:06 -0500
Received: from mx1.redhat.com ([66.187.233.31]:48537 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751416AbWBRQpF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Feb 2006 11:45:05 -0500
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20060218113602.edc06ce5.davi.arnaut@gmail.com> 
References: <20060218113602.edc06ce5.davi.arnaut@gmail.com> 
To: Davi Arnaut <davi.arnaut@gmail.com>
Cc: akpm@osdl.org, dhowells@redhat.com, vsu@altlinux.ru,
       alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] strndup_user (v3), convert (keyctl) 
X-Mailer: MH-E 7.91+cvs; nmh 1.1; GNU Emacs 22.0.50.1
Date: Sat, 18 Feb 2006 16:44:49 +0000
Message-ID: <3487.1140281089@warthog.cambridge.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Davi Arnaut <davi.arnaut@gmail.com> wrote:

> Convert security/keys/keyctl.c string duplication to strdup_user()

Can you redo this on top of hose patches I submitted yesterday please?

David
