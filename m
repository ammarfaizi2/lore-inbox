Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271730AbTHDNWa (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Aug 2003 09:22:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271731AbTHDNWa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Aug 2003 09:22:30 -0400
Received: from mail3.ithnet.com ([217.64.64.7]:65206 "HELO
	heather-ng.ithnet.com") by vger.kernel.org with SMTP
	id S271730AbTHDNW3 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Aug 2003 09:22:29 -0400
X-Sender-Authentification: SMTPafterPOP by <info@euro-tv.de> from 217.64.64.14
Date: Mon, 4 Aug 2003 15:22:26 +0200
From: Stephan von Krawczynski <skraw@ithnet.com>
To: mru@users.sourceforge.net (=?ISO-8859-15?Q?M=E5ns_Rullg=E5rd?=)
Cc: linux-kernel@vger.kernel.org
Subject: Re: FS: hardlinks on directories
Message-Id: <20030804152226.60204b61.skraw@ithnet.com>
In-Reply-To: <yw1xsmohioah.fsf@users.sourceforge.net>
References: <20030804141548.5060b9db.skraw@ithnet.com>
	<yw1xsmohioah.fsf@users.sourceforge.net>
Organization: ith Kommunikationstechnik GmbH
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 04 Aug 2003 14:45:58 +0200
mru@users.sourceforge.net (Måns Rullgård) wrote:

> Stephan von Krawczynski <skraw@ithnet.com> writes:
> 
> > although it is very likely I am entering (again :-) an ancient
> > discussion I would like to ask why hardlinks on directories are not
> > allowed/no supported fs action these days. I can't think of a good
> > reason for this, but can think of many good reasons why one would
> > like to have such a function, amongst those:
> 
> I don't know the exact reasons it isn't allowed, but you can always
> use "mount --bind" to get a similar effect.

I guess this is not really an option if talking about hundreds or thousands of
"links", is it?

Regards,
Stephan
