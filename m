Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964834AbWCHQkO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964834AbWCHQkO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Mar 2006 11:40:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932390AbWCHQkO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Mar 2006 11:40:14 -0500
Received: from hierophant.serpentine.com ([66.92.13.71]:45771 "EHLO
	demesne.serpentine.com") by vger.kernel.org with ESMTP
	id S1751501AbWCHQkM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Mar 2006 11:40:12 -0500
Subject: Re: [PATCH] Document Linux's memory barriers
From: "Bryan O'Sullivan" <bos@serpentine.com>
To: David Howells <dhowells@redhat.com>
Cc: Linus Torvalds <torvalds@osdl.org>, Paul Mackerras <paulus@samba.org>,
       akpm@osdl.org, mingo@redhat.com, linux-arch@vger.kernel.org,
       linuxppc64-dev@ozlabs.org, linux-kernel@vger.kernel.org
In-Reply-To: <27607.1141821265@warthog.cambridge.redhat.com>
References: <Pine.LNX.4.64.0603071918460.32577@g5.osdl.org>
	 <31492.1141753245@warthog.cambridge.redhat.com>
	 <17422.19209.60360.178668@cargo.ozlabs.ibm.com>
	 <27607.1141821265@warthog.cambridge.redhat.com>
Content-Type: text/plain
Date: Wed, 08 Mar 2006 08:40:11 -0800
Message-Id: <1141836011.4347.22.camel@camp4.serpentine.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-03-08 at 12:34 +0000, David Howells wrote:

> On i386 and x86_64, do IN and OUT instructions imply MFENCE?

No.

	<b

