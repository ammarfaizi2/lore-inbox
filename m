Return-Path: <linux-kernel-owner+w=401wt.eu-S933099AbWLaJX0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933099AbWLaJX0 (ORCPT <rfc822;w@1wt.eu>);
	Sun, 31 Dec 2006 04:23:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933100AbWLaJXZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 31 Dec 2006 04:23:25 -0500
Received: from javad.com ([216.122.176.236]:1791 "EHLO javad.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933099AbWLaJXZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 31 Dec 2006 04:23:25 -0500
From: Sergei Organov <osv@javad.com>
To: Jiri Slaby <jirislaby@gmail.com>
Cc: Andrew Morton <akpm@osdl.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 4/4] Char: mxser_new, fix twice resource releasing
References: <223225458143254603@wsc.cz>
Date: Sun, 31 Dec 2006 12:23:13 +0300
In-Reply-To: <223225458143254603@wsc.cz> (Jiri Slaby's message of "Fri, 29
 Dec
	2006 21:56:25 +0100 (CET)")
Message-ID: <87odpkl8qm.fsf@javad.com>
User-Agent: Gnus/5.110006 (No Gnus v0.6) XEmacs/21.4.19 (linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jiri Slaby <jirislaby@gmail.com> writes:

> mxser_new, fix twice resource releasing
>

Hi Jiri,

I've noticed the patch(es) and will be happy to test them after the
holidays.

Thank you very much for working on these issues and Happy New Year!

-- Sergei.
