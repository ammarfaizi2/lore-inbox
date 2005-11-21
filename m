Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964778AbVKUXon@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964778AbVKUXon (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Nov 2005 18:44:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964780AbVKUXon
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Nov 2005 18:44:43 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:19118 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S964778AbVKUXom
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Nov 2005 18:44:42 -0500
Date: Mon, 21 Nov 2005 23:44:40 +0000
From: Al Viro <viro@ftp.linux.org.uk>
To: Sam Ravnborg <sam@ravnborg.org>
Cc: Roman Zippel <zippel@linux-m68k.org>, linux-kernel@vger.kernel.org
Subject: Re: [2/7] kconfig: lxdialog is now sparse clean
Message-ID: <20051121234440.GH27946@ftp.linux.org.uk>
References: <20051121223702.GA19157@mars.ravnborg.org> <20051121223853.GC19157@mars.ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051121223853.GC19157@mars.ravnborg.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 21, 2005 at 11:38:53PM +0100, Sam Ravnborg wrote:
>     kconfig: lxdialog is now sparse clean
>     
>     Replacing a gcc idiom with malloc and deleting an unused global
>     variable made lxdialog sparse clean.

You do realize that this is not a gccism, right?
