Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272583AbTHEIE2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Aug 2003 04:04:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272584AbTHEIE2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Aug 2003 04:04:28 -0400
Received: from mail3.ithnet.com ([217.64.64.7]:38379 "HELO
	heather-ng.ithnet.com") by vger.kernel.org with SMTP
	id S272583AbTHEIEZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Aug 2003 04:04:25 -0400
X-Sender-Authentification: SMTPafterPOP by <info@euro-tv.de> from 217.64.64.14
Date: Tue, 5 Aug 2003 10:04:22 +0200
From: Stephan von Krawczynski <skraw@ithnet.com>
To: Andrew Pimlott <andrew@pimlott.net>
Cc: aia21@cam.ac.uk, aebr@win.tue.nl, linux-kernel@vger.kernel.org
Subject: Re: FS: hardlinks on directories
Message-Id: <20030805100422.3765252b.skraw@ithnet.com>
In-Reply-To: <20030805011820.GB23512@pimlott.net>
References: <20030804141548.5060b9db.skraw@ithnet.com>
	<20030804134415.GA4454@win.tue.nl>
	<20030804155604.2cdb96e7.skraw@ithnet.com>
	<Pine.SOL.4.56.0308041458500.22102@orange.csi.cam.ac.uk>
	<20030804165002.791aae3d.skraw@ithnet.com>
	<20030805011820.GB23512@pimlott.net>
Organization: ith Kommunikationstechnik GmbH
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 4 Aug 2003 21:18:20 -0400
Andrew Pimlott <andrew@pimlott.net> wrote:

> On Tue, Aug 05, 2003 at 02:19:38AM +0200, Stephan von Krawczynski wrote:

> Wouldn't bind mounts solve your problem?  Why are you still
> interested in hard links?

Because mount -bind cannot be exported over nfs (to my current knowledge and
testing). Else I would be very pleased to use it.

Regards,
Stephan
