Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272832AbTHEPM2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Aug 2003 11:12:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272835AbTHEPM2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Aug 2003 11:12:28 -0400
Received: from mail3.ithnet.com ([217.64.64.7]:55715 "HELO
	heather-ng.ithnet.com") by vger.kernel.org with SMTP
	id S272832AbTHEPM1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Aug 2003 11:12:27 -0400
X-Sender-Authentification: SMTPafterPOP by <info@euro-tv.de> from 217.64.64.14
Date: Tue, 5 Aug 2003 17:12:24 +0200
From: Stephan von Krawczynski <skraw@ithnet.com>
To: Jesse Pollard <jesse@cats-chateau.net>
Cc: root@chaos.analogic.com, helgehaf@aitel.hist.no,
       linux-kernel@vger.kernel.org
Subject: Re: FS: hardlinks on directories
Message-Id: <20030805171224.7237cedc.skraw@ithnet.com>
In-Reply-To: <03080510020503.05972@tabby>
References: <20030804141548.5060b9db.skraw@ithnet.com>
	<Pine.LNX.4.53.0308050916140.5994@chaos>
	<20030805160435.7b151b0e.skraw@ithnet.com>
	<03080510020503.05972@tabby>
Organization: ith Kommunikationstechnik GmbH
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 5 Aug 2003 10:02:04 -0500
Jesse Pollard <jesse@cats-chateau.net> wrote:

> On Tuesday 05 August 2003 09:04, Stephan von Krawczynski wrote:

> > So, instead of constantly feeding my bad conscience, can some kind soul
> > explain the possibilities to make "mount -bind/rbind" work over a network
> > fs of some flavor, please?
> 
> Not sure, but I suspect there would be a problem IF the -bind mount crosses 
> filesystems. If it doesn't cross the filesystems I wouldn't think there
> would be much problem.

Hm, that would be quite ok in my eyes. Obviously it would be nice if total
re-export were possible, but as a first step within the same device sounds ok.

Regards,
Stephan

