Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262157AbVANUxW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262157AbVANUxW (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Jan 2005 15:53:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262106AbVANUwh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Jan 2005 15:52:37 -0500
Received: from pfepc.post.tele.dk ([195.41.46.237]:43825 "EHLO
	pfepc.post.tele.dk") by vger.kernel.org with ESMTP id S262111AbVANUwL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Jan 2005 15:52:11 -0500
Date: Fri, 14 Jan 2005 21:52:42 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: Karim Yaghmour <karim@opersys.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel <linux-kernel@vger.kernel.org>,
       LTT-Dev <ltt-dev@shafik.org>
Subject: Re: [PATCH 1/8 ] ltt for 2.6.10: core implementation
Message-ID: <20050114205242.GC8385@mars.ravnborg.org>
Mail-Followup-To: Karim Yaghmour <karim@opersys.com>,
	Andrew Morton <akpm@osdl.org>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	LTT-Dev <ltt-dev@shafik.org>
References: <41E76271.3000004@opersys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41E76271.3000004@opersys.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Karim.

> + * (C) Copyright, 1999, 2000, 2001, 2002, 2003, 2004 -
> + *              Karim Yaghmour (karim@opersys.com)
2005?

> + * Changelog:
> + *	14/12/04, Renamed trace macros and variables to avoid namespace
> + *		pollution (i.e. TRACE_XXX is now ltt_ev_xxx, etc.)
...
Common practice is not to include Changelog in files.

	Sam
