Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262256AbUE1KjV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262256AbUE1KjV (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 May 2004 06:39:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265875AbUE1KjV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 May 2004 06:39:21 -0400
Received: from delerium.kernelslacker.org ([81.187.208.145]:10462 "EHLO
	delerium.codemonkey.org.uk") by vger.kernel.org with ESMTP
	id S262256AbUE1KjR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 May 2004 06:39:17 -0400
Date: Fri, 28 May 2004 11:37:47 +0100
From: Dave Jones <davej@redhat.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Andrey Panin <pazke@donpac.ru>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.7-rc1-mm1
Message-ID: <20040528103747.GA11265@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Andrew Morton <akpm@osdl.org>, Andrey Panin <pazke@donpac.ru>,
	linux-kernel@vger.kernel.org
References: <20040527015259.3525cbbc.akpm@osdl.org> <20040527115327.GA7499@pazke> <20040527112041.531a52e4.akpm@osdl.org> <20040528054653.GB7499@pazke> <20040527225231.722c3a93.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040527225231.722c3a93.akpm@osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 27, 2004 at 10:52:31PM -0700, Andrew Morton wrote:

 > > > Confused.  What's the problem with that?
 > > Just yet another rediff of my DMI patches :)
 > err, what DMI patches?

Andrey's very nice cleanup of the DMI handlers, which pretty
much everyone agreed was a vast improvement over what we currently
have.

Andrey: I've got 1-2 patches pending for the DMI stuff too,
but I'll wait until your stuff has got merged somewhere,
and then mail incrementals on top.

		Dave

