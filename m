Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272910AbTHEOoy (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Aug 2003 10:44:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272911AbTHEOox
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Aug 2003 10:44:53 -0400
Received: from mail3.ithnet.com ([217.64.64.7]:39073 "HELO
	heather-ng.ithnet.com") by vger.kernel.org with SMTP
	id S272910AbTHEOov (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Aug 2003 10:44:51 -0400
X-Sender-Authentification: SMTPafterPOP by <info@euro-tv.de> from 217.64.64.14
Date: Tue, 5 Aug 2003 16:44:49 +0200
From: Stephan von Krawczynski <skraw@ithnet.com>
To: Jesse Pollard <jesse@cats-chateau.net>
Cc: aia21@cam.ac.uk, aebr@win.tue.nl, linux-kernel@vger.kernel.org
Subject: Re: FS: hardlinks on directories
Message-Id: <20030805164449.788e11e9.skraw@ithnet.com>
In-Reply-To: <03080509204101.05972@tabby>
References: <20030804141548.5060b9db.skraw@ithnet.com>
	<03080416163901.04444@tabby>
	<20030805013425.03fb9871.skraw@ithnet.com>
	<03080509204101.05972@tabby>
Organization: ith Kommunikationstechnik GmbH
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 5 Aug 2003 09:20:41 -0500
Jesse Pollard <jesse@cats-chateau.net> wrote:

> > This is the reason why I would in fact be satisfied with mount -bind if
> > only I could export it via nfs...
> 
> it's a MOUNT point. NFS doesn't export across mount points just as it doesn't
> allow exporting a NFS mounted directory.

Hm, I surely have seen re-exports in the past and used them myself, though I
did not check under 2.4 setups lately.
I definitely know old SuSE distros had a flag for that in rc.config.

Regards,
Stephan
