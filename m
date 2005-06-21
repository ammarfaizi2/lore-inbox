Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262299AbVFUUH5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262299AbVFUUH5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Jun 2005 16:07:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262258AbVFUUHn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Jun 2005 16:07:43 -0400
Received: from graphe.net ([209.204.138.32]:12447 "EHLO graphe.net")
	by vger.kernel.org with ESMTP id S261453AbVFUUGr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Jun 2005 16:06:47 -0400
Date: Tue, 21 Jun 2005 13:06:41 -0700 (PDT)
From: Christoph Lameter <christoph@lameter.com>
X-X-Sender: christoph@graphe.net
To: Zan Lynx <zlynx@acm.org>
cc: Robert Love <rml@novell.com>, Jeff Garzik <jgarzik@pobox.com>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: -mm -> 2.6.13 merge status
In-Reply-To: <1119384131.15478.25.camel@localhost>
Message-ID: <Pine.LNX.4.62.0506211306060.22372@graphe.net>
References: <20050620235458.5b437274.akpm@osdl.org>  <42B831B4.9020603@pobox.com>
 <1119368364.3949.236.camel@betsy>  <Pine.LNX.4.62.0506211222040.21678@graphe.net>
  <1119382685.3949.263.camel@betsy> <1119384131.15478.25.camel@localhost>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Score: -5.9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 21 Jun 2005, Zan Lynx wrote:

> I've never tried doing that.  It might work, for all I know.

I was told that Linux cannot do this. It always returns the filehandles as 
ready for disk files.

