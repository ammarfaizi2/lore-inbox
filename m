Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932100AbWAZJmI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932100AbWAZJmI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Jan 2006 04:42:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932138AbWAZJmH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Jan 2006 04:42:07 -0500
Received: from mx1.redhat.com ([66.187.233.31]:29365 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932100AbWAZJmG convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Jan 2006 04:42:06 -0500
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20060125191402.GB12039@hardeman.nu> 
References: <20060125191402.GB12039@hardeman.nu>  <11380489522073@2gen.com> <17755.1138100925@hades.cambridge.redhat.com> 
To: David =?us-ascii?Q?=3D=3Fiso-8859-1=3FQ=3FH=3DE4rdeman=3F=3D?= 
	<david@2gen.com>
Cc: David Howells <dhowells@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 04/04] Add dsa key type 
X-Mailer: MH-E 7.84; nmh 1.1; GNU Emacs 22.0.50.1
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Date: Thu, 26 Jan 2006 09:41:54 +0000
Message-ID: <18900.1138268514@hades.cambridge.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Härdeman <david@2gen.com> wrote:

> That was already added by one of the earlier patches as include/dsa.h since
> its shared by crypto/dsa.c and security/keys/dsa_key.c, do you prefer some
> other solution?

That'll do then.

David
