Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262251AbTJIPYD (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Oct 2003 11:24:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262262AbTJIPYD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Oct 2003 11:24:03 -0400
Received: from pasmtp.tele.dk ([193.162.159.95]:23556 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S262251AbTJIPX7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Oct 2003 11:23:59 -0400
Date: Thu, 9 Oct 2003 17:23:50 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Mark Hounschell <markh@compro.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Can't build external module against 2.6.0-test6 kernel
Message-ID: <20031009152350.GA897@mars.ravnborg.org>
Mail-Followup-To: Mark Hounschell <markh@compro.net>,
	linux-kernel@vger.kernel.org
References: <3F8544DF.85E7CA81@compro.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3F8544DF.85E7CA81@compro.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 09, 2003 at 07:22:07AM -0400, Mark Hounschell wrote:
> I'm trying to build a driver external to the kernel. I'm running 2.6.0-test6
> kernel.
> It appears to me (I'm probably wrong) that there is a kernel include file issue.
Please follow Documentation/kbuild/modules.txt when building
external modules.

Please come back if you continue to have problems.

	Sam
