Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271744AbTHDN4I (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Aug 2003 09:56:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271746AbTHDN4I
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Aug 2003 09:56:08 -0400
Received: from mail3.ithnet.com ([217.64.64.7]:2746 "HELO
	heather-ng.ithnet.com") by vger.kernel.org with SMTP
	id S271744AbTHDN4G (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Aug 2003 09:56:06 -0400
X-Sender-Authentification: SMTPafterPOP by <info@euro-tv.de> from 217.64.64.14
Date: Mon, 4 Aug 2003 15:56:04 +0200
From: Stephan von Krawczynski <skraw@ithnet.com>
To: Andries Brouwer <aebr@win.tue.nl>
Cc: linux-kernel@vger.kernel.org
Subject: Re: FS: hardlinks on directories
Message-Id: <20030804155604.2cdb96e7.skraw@ithnet.com>
In-Reply-To: <20030804134415.GA4454@win.tue.nl>
References: <20030804141548.5060b9db.skraw@ithnet.com>
	<20030804134415.GA4454@win.tue.nl>
Organization: ith Kommunikationstechnik GmbH
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 4 Aug 2003 15:44:15 +0200
Andries Brouwer <aebr@win.tue.nl> wrote:

> On Mon, Aug 04, 2003 at 02:15:48PM +0200, Stephan von Krawczynski wrote:
> 
> > although it is very likely I am entering (again :-) an ancient discussion I
> > would like to ask why hardlinks on directories are not allowed/no supported
> > fs action these days.
> 
> Quite a lot of software thinks that the file hierarchy is a tree,
> if you wish a forest.
> 
> Things would break badly if the hierarchy became an arbitrary graph.

Care to name one? What exactly is the rule you see broken? Sure you can build
loops, but you cannot prevent people from doing braindamaged things to their
data anyway. You would not ban dd either for being able to flatten your
harddisk only because of one mistyping char...
Every feature can be misused and then damaging, but that is no real reason not
to have it - IMHO.

Regards,
Stephan
