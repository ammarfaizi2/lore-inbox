Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272572AbTHELDz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Aug 2003 07:03:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272644AbTHELDz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Aug 2003 07:03:55 -0400
Received: from dial249.pm3abing3.abingdonpm.naxs.com ([216.98.75.249]:48015
	"EHLO animx.eu.org") by vger.kernel.org with ESMTP id S272572AbTHELDv
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Aug 2003 07:03:51 -0400
Date: Tue, 5 Aug 2003 07:18:38 -0400
From: Wakko Warner <wakko@animx.eu.org>
To: Stephan von Krawczynski <skraw@ithnet.com>
Cc: Andrew Pimlott <andrew@pimlott.net>, aia21@cam.ac.uk, aebr@win.tue.nl,
       linux-kernel@vger.kernel.org
Subject: Re: FS: hardlinks on directories
Message-ID: <20030805071838.A5925@animx.eu.org>
References: <20030804141548.5060b9db.skraw@ithnet.com> <20030804134415.GA4454@win.tue.nl> <20030804155604.2cdb96e7.skraw@ithnet.com> <Pine.SOL.4.56.0308041458500.22102@orange.csi.cam.ac.uk> <20030804165002.791aae3d.skraw@ithnet.com> <20030805011820.GB23512@pimlott.net> <20030805100422.3765252b.skraw@ithnet.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.95.3i
In-Reply-To: <20030805100422.3765252b.skraw@ithnet.com>; from Stephan von Krawczynski on Tue, Aug 05, 2003 at 10:04:22AM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > Wouldn't bind mounts solve your problem?  Why are you still
> > interested in hard links?
> 
> Because mount -bind cannot be exported over nfs (to my current knowledge and
> testing). Else I would be very pleased to use it.

The userspace NFS server may support this.  Unfortunately, it only supports
NFSv2.

-- 
 Lab tests show that use of micro$oft causes cancer in lab animals
