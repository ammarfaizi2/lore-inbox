Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263357AbTJKR7U (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Oct 2003 13:59:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263358AbTJKR7U
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Oct 2003 13:59:20 -0400
Received: from pizda.ninka.net ([216.101.162.242]:19585 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id S263357AbTJKR7T (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Oct 2003 13:59:19 -0400
Date: Sat, 11 Oct 2003 10:53:20 -0700
From: "David S. Miller" <davem@redhat.com>
To: Michael Hunold <hunold@convergence.de>
Cc: shemminger@osdl.org, linux-dvb@linuxtv.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/14] LinuxTV.org DVB driver update
Message-Id: <20031011105320.1c9d46db.davem@redhat.com>
In-Reply-To: <3F87C247.7030808@convergence.de>
References: <10656197274033@convergence.de>
	<20031010131538.74b78a14.shemminger@osdl.org>
	<3F87C247.7030808@convergence.de>
X-Mailer: Sylpheed version 0.9.2 (GTK+ 1.2.6; sparc-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 11 Oct 2003 10:41:43 +0200
Michael Hunold <hunold@convergence.de> wrote:

> Unfortunately, I don't notice every patch that goes directly into 2.6 
> without getting postet on the linux-dvb mailinglist. Now if someone 
> changes stuff in our CVS in the same file, it can happen that the stuff 
> from the kernel is wiped out.

It is your responsibility to resolve such things though.  It is
inevitable and unavoidable that others outside of your development
group will make many changes to your files, as we fix bugs that
are tree-wide.
