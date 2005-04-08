Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262841AbVDHOyu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262841AbVDHOyu (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Apr 2005 10:54:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262839AbVDHOyu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Apr 2005 10:54:50 -0400
Received: from pfepb.post.tele.dk ([195.41.46.236]:42253 "EHLO
	pfepb.post.tele.dk") by vger.kernel.org with ESMTP id S262843AbVDHOyp
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Apr 2005 10:54:45 -0400
Date: Fri, 8 Apr 2005 16:55:27 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Ian Molton <spyro@f2s.com>
Cc: Greg KH <gregkh@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: PATCH add support for system on chip (SoC) devices.
Message-ID: <20050408145527.GB8227@mars.ravnborg.org>
References: <42569300.7070008@f2s.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42569300.7070008@f2s.com>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 08, 2005 at 03:19:44PM +0100, Ian Molton wrote:
> Hi.
> 
> This patch add support for a new 'System on Chip' or SoC bus type.

Hi Ian.

A few general comments.
1) Please add kernel-doc style comments for all exported functions
2) Keep source within 80 coloumns
3) Do not use extern in front of function definition

	Sam
