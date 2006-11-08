Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161451AbWKHSbk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161451AbWKHSbk (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Nov 2006 13:31:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754650AbWKHSbk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Nov 2006 13:31:40 -0500
Received: from mtagate1.de.ibm.com ([195.212.29.150]:18733 "EHLO
	mtagate1.de.ibm.com") by vger.kernel.org with ESMTP
	id S1754647AbWKHSbi convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Nov 2006 13:31:38 -0500
In-Reply-To: <20061108170916.GA570@wohnheim.fh-wedel.de>
Subject: Re: How to document dimension units for virtual files?
To: =?ISO-8859-1?Q?J=F6rn_Engel?= <joern@wohnheim.fh-wedel.de>
Cc: Ingo Oeser <ioe-lkml@rameria.de>, linux-kernel@vger.kernel.org,
       mschwid2@de.ibm.com, pavel@ucw.cz
X-Mailer: Lotus Notes Build V70_M4_01112005 Beta 3NP January 11, 2005
Message-ID: <OF31FCCC98.31A543B2-ON41257220.006579A9-41257220.0065DD0F@de.ibm.com>
From: Michael Holzheu <HOLZHEU@de.ibm.com>
Date: Wed, 8 Nov 2006 19:32:37 +0100
X-MIMETrack: Serialize by Router on D12ML061/12/M/IBM(Release 6.5.5HF607 | June 26, 2006) at
 08/11/2006 19:34:41
MIME-Version: 1.0
Content-type: text/plain; charset=ISO-8859-1
Content-transfer-encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jörn Engel <joern@wohnheim.fh-wedel.de> wrote on 11/08/2006 06:09:16 PM:

> On Wed, 8 November 2006 17:54:12 +0100, Michael Holzheu wrote:
> >
> > What about the following ...
>
> Awesome.  The next time someone flames me over this subject, I can
> simly refer to this file.
>
> One could nitpick that a) this applies to any interface, so it also
> includes kernel command line and module parameters and b) there are
> existing interfaces that interpret "kb" as 2^10 bytes, etc.  Maybe
> this could be noted somehow, but it's not too important imho.
>

a) Right, that is a more general "problem". But I am not sure, if I want
to solve/decide that.
b) I wanted to document the recommendations, I didn't want to
document what currently is done.

Michael

