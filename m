Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964812AbVKRQ4z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964812AbVKRQ4z (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Nov 2005 11:56:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964815AbVKRQ4y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Nov 2005 11:56:54 -0500
Received: from ns1.suse.de ([195.135.220.2]:30671 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S964812AbVKRQ4y (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Nov 2005 11:56:54 -0500
Date: Fri, 18 Nov 2005 17:56:48 +0100
From: jblunck@suse.com
To: "Alexander E. Patrakov" <patrakov@ums.usu.ru>
Cc: Alasdair G Kergon <agk@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] device-mapper snapshot: bio_list fix
Message-ID: <20051118165648.GB23178@hasse.suse.de>
References: <20051118145547.GK11878@agk.surrey.redhat.com> <437DF42B.8000008@ums.usu.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <437DF42B.8000008@ums.usu.ru>
"From: jblunck@suse.de"
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 18, Alexander E. Patrakov wrote:

> Could you please tell how to reproduce this oops using e.g. loop 
> devices? This patch looks relevant to my Live CD (although no oops has 
> been reported yet).
> 

Its not an oops but hanging on I/O to finish.

Regards,
	Jan

-- 
Jan Blunck                                               jblunck@suse.de
SuSE LINUX AG - A Novell company
Maxfeldstr. 5                                          +49-911-74053-608
D-90409 Nürnberg                                      http://www.suse.de
