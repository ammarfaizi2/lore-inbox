Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265252AbTFZA6s (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Jun 2003 20:58:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265247AbTFZA5K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Jun 2003 20:57:10 -0400
Received: from deviant.impure.org.uk ([195.82.120.238]:64658 "EHLO
	deviant.impure.org.uk") by vger.kernel.org with ESMTP
	id S265279AbTFZAzD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Jun 2003 20:55:03 -0400
Date: Thu, 26 Jun 2003 02:09:07 +0100
From: Dave Jones <davej@codemonkey.org.uk>
To: Marcelo Penna Guerra <eu@marcelopenna.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] nVidia nForce AGP fix
Message-ID: <20030626010906.GC18101@suse.de>
Mail-Followup-To: Dave Jones <davej@codemonkey.org.uk>,
	Marcelo Penna Guerra <eu@marcelopenna.org>,
	linux-kernel@vger.kernel.org
References: <200306241903.14271.eu@marcelopenna.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200306241903.14271.eu@marcelopenna.org>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 24, 2003 at 07:03:14PM -0300, Marcelo Penna Guerra wrote:

 > nVidia nForce AGP is broken in 2.4.21-ac2. This patch fixed it for me.
 > I think 2.5.x needs a similar fix too.

Looks like you're right. Good catch. Fixed in my pending tree.

		Dave
