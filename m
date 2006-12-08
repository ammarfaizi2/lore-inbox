Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1760846AbWLHSsT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760846AbWLHSsT (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Dec 2006 13:48:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760849AbWLHSsT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Dec 2006 13:48:19 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:42137 "EHLO
	ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760846AbWLHSsS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Dec 2006 13:48:18 -0500
Date: Fri, 8 Dec 2006 18:48:15 +0000
From: Al Viro <viro@ftp.linux.org.uk>
To: David Howells <dhowells@redhat.com>
Cc: torvalds@osdl.org, akpm@osdl.org, schwidefsky@de.ibm.com,
       linux390@de.ibm.com, linux-kernel@vger.kernel.org,
       linux-arch@vger.kernel.org
Subject: Re: [PATCH] WorkStruct: Fix S390 driver workstruct usage
Message-ID: <20061208184814.GX4587@ftp.linux.org.uk>
References: <20061208145940.21411.77769.stgit@warthog.cambridge.redhat.com> <20061208173342.GT4587@ftp.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061208173342.GT4587@ftp.linux.org.uk>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 08, 2006 at 05:33:43PM +0000, Al Viro wrote:

[snip]

my apologies if that got sent more than once ;-/
