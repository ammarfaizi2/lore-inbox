Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261769AbTJMUum (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Oct 2003 16:50:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261930AbTJMUum
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Oct 2003 16:50:42 -0400
Received: from pasmtp.tele.dk ([193.162.159.95]:2057 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S261769AbTJMUul (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Oct 2003 16:50:41 -0400
Date: Mon, 13 Oct 2003 22:50:39 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Olaf Hering <olh@suse.de>
Cc: Linus Torvalds <torvalds@osdl.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: gcc -msoft-float [Was: Linux 2.6.0-test7 - stability freeze]
Message-ID: <20031013205039.GA1638@mars.ravnborg.org>
Mail-Followup-To: Olaf Hering <olh@suse.de>,
	Linus Torvalds <torvalds@osdl.org>,
	Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.44.0310081235280.4017-100000@home.osdl.org> <20031013173446.GA13186@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031013173446.GA13186@suse.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 13, 2003 at 07:34:46PM +0200, Olaf Hering wrote:
> a longstanding bug, should probably go to the main Makefile. But I dont
> know if all supported archs know about -msoft-float.

Could you please elaborate about what this fixes.
I'm very resistant to add new flags unconditionally to gcc at this stage.

	Sam
