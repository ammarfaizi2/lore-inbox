Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265586AbTGDA4A (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Jul 2003 20:56:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265598AbTGDA4A
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Jul 2003 20:56:00 -0400
Received: from bristol.phunnypharm.org ([65.207.35.130]:28628 "EHLO
	bristol.phunnypharm.org") by vger.kernel.org with ESMTP
	id S265586AbTGDAz7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Jul 2003 20:55:59 -0400
Date: Thu, 3 Jul 2003 19:50:39 -0400
From: Ben Collins <bcollins@debian.org>
To: James Simmons <jsimmons@infradead.org>
Cc: Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: New fbdev updates.
Message-ID: <20030703235039.GB502@phunnypharm.org>
References: <Pine.LNX.4.44.0307031847570.16727-100000@phoenix.infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0307031847570.16727-100000@phoenix.infradead.org>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 03, 2003 at 06:55:58PM +0100, James Simmons wrote:
> 
> Hi!
>    
>    I have updates to the framebuffer layer. Alot of bug fixes accumlated. 
> A couple of driver updates as well. I have more code to go in but haven't 
> had time to add them in. Please test. This is not the final code going in 
> just yet. More needs to be done. The patches are at the usual

Seems my old corrupt cursor is fixed, but with your new code I am
getting ghost cursors left behind while moving around in vim over ssh
with syntax on.

-- 
Debian     - http://www.debian.org/
Linux 1394 - http://www.linux1394.org/
Subversion - http://subversion.tigris.org/
Deqo       - http://www.deqo.com/
