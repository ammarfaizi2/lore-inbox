Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272816AbTHEOV4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Aug 2003 10:21:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272817AbTHEOV4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Aug 2003 10:21:56 -0400
Received: from mail3.ithnet.com ([217.64.64.7]:49311 "HELO
	heather-ng.ithnet.com") by vger.kernel.org with SMTP
	id S272816AbTHEOVz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Aug 2003 10:21:55 -0400
X-Sender-Authentification: SMTPafterPOP by <info@euro-tv.de> from 217.64.64.14
Date: Tue, 5 Aug 2003 16:21:52 +0200
From: Stephan von Krawczynski <skraw@ithnet.com>
To: Jesse Pollard <jesse@cats-chateau.net>
Cc: aebr@win.tue.nl, linux-kernel@vger.kernel.org
Subject: Re: FS: hardlinks on directories
Message-Id: <20030805162152.2975dc33.skraw@ithnet.com>
In-Reply-To: <03080509123100.05972@tabby>
References: <20030804141548.5060b9db.skraw@ithnet.com>
	<03080416092800.04444@tabby>
	<20030805003210.2c7f75f6.skraw@ithnet.com>
	<03080509123100.05972@tabby>
Organization: ith Kommunikationstechnik GmbH
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 5 Aug 2003 09:12:31 -0500
Jesse Pollard <jesse@cats-chateau.net> wrote:

> > If you can do the fs patch, I can do the tar patch.
> 
> The patch is FAR too extensive. It would have to be a whole new filesystem

Fine. This is a clear and straight forward word. Can you explain why I don't
see the mount -bind/rbind stuff through nfs? Is this a problem with a cheaper
solution?

Regards,
Stephan


