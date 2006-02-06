Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751066AbWBFMb4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751066AbWBFMb4 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Feb 2006 07:31:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751071AbWBFMbz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Feb 2006 07:31:55 -0500
Received: from mx1.redhat.com ([66.187.233.31]:63619 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1750874AbWBFMby (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Feb 2006 07:31:54 -0500
From: David Howells <dhowells@redhat.com>
In-Reply-To: <1138567954.17148.4.camel@laptopd505.fenrus.org> 
References: <1138567954.17148.4.camel@laptopd505.fenrus.org>  <1138312694656@2gen.com> <1138312695665@2gen.com> <6403.1138392470@warthog.cambridge.redhat.com> <20060127204158.GA4754@hardeman.nu> <20060128002241.GD3777@stusta.de> <20060128104611.GA4348@hardeman.nu> <1138466271.8770.77.camel@lade.trondhjem.org> <20060128165732.GA8633@hardeman.nu> <1138504829.8770.125.camel@lade.trondhjem.org> <20060129113320.GA21386@hardeman.nu> <20060129122901.GX3777@stusta.de> <1138540148.3002.9.camel@laptopd505.fenrus.org> <43DD2010.7010700@austin.rr.com> 
To: Arjan van de Ven <arjan@infradead.org>
Cc: Steve French <smfrench@austin.rr.com>, keyrings@linux-nfs.org,
       linux-kernel@vger.kernel.org
Subject: Re: [Keyrings] Re: [PATCH 01/04] Add multi-precision-integer maths library 
X-Mailer: MH-E 7.84; nmh 1.1; GNU Emacs 22.0.50.1
Date: Mon, 06 Feb 2006 12:31:37 +0000
Message-ID: <16266.1139229097@warthog.cambridge.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arjan van de Ven <arjan@infradead.org> wrote:

> 3) to allow kernel pieces to do key things, like the secure nfs parts of
> nfsv4 or ipsec.

Also eCryptFS.

David
