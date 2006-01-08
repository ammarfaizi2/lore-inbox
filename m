Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752654AbWAHRrk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752654AbWAHRrk (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Jan 2006 12:47:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752653AbWAHRrk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Jan 2006 12:47:40 -0500
Received: from pasmtp.tele.dk ([193.162.159.95]:54537 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S1752654AbWAHRrj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Jan 2006 12:47:39 -0500
Date: Sun, 8 Jan 2006 18:47:24 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: Tore Anderson <tore@fud.no>
Cc: kai@germaschewski.name, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6] Makefile: ensure mrproper removes .old_version
Message-ID: <20060108174724.GA11233@mars.ravnborg.org>
References: <20060107143440.GB3378@fud.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060107143440.GB3378@fud.no>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 07, 2006 at 03:34:40PM +0100, Tore Anderson wrote:
> If the final linking of vmlinux fails, the file .old_version are left
> behind.  This patch ensures the mrproper target will remove it if
> present.
Applied,
	Sam
