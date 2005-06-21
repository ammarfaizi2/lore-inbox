Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262255AbVFUTix@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262255AbVFUTix (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Jun 2005 15:38:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262260AbVFUTix
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Jun 2005 15:38:53 -0400
Received: from peabody.ximian.com ([130.57.169.10]:24488 "EHLO
	peabody.ximian.com") by vger.kernel.org with ESMTP id S262255AbVFUTiD
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Jun 2005 15:38:03 -0400
Subject: Re: -mm -> 2.6.13 merge status
From: Robert Love <rml@novell.com>
To: Christoph Lameter <christoph@lameter.com>
Cc: Jeff Garzik <jgarzik@pobox.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.62.0506211222040.21678@graphe.net>
References: <20050620235458.5b437274.akpm@osdl.org>
	 <42B831B4.9020603@pobox.com> <1119368364.3949.236.camel@betsy>
	 <Pine.LNX.4.62.0506211222040.21678@graphe.net>
Content-Type: text/plain
Date: Tue, 21 Jun 2005 15:38:05 -0400
Message-Id: <1119382685.3949.263.camel@betsy>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-06-21 at 12:22 -0700, Christoph Lameter wrote:

> I noticed that select() is not working on real files. Could inotify 
> be used to fix select()?

Select the system call?  It should work fine.   ;-)

Who is confused?

	Robert Love


