Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263455AbVGATg5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263455AbVGATg5 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Jul 2005 15:36:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263441AbVGATgl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Jul 2005 15:36:41 -0400
Received: from smtp.andrew.cmu.edu ([128.2.10.83]:49551 "EHLO
	smtp.andrew.cmu.edu") by vger.kernel.org with ESMTP id S263440AbVGATfL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Jul 2005 15:35:11 -0400
From: Jeremy Maitin-Shepard <jbms@cmu.edu>
To: linux-kernel@vger.kernel.org
Subject: Re: FUSE merging?
References: <20050630222828.GA32357@janus>
	<E1DoFTR-0002NH-00@dorka.pomaz.szeredi.hu> <20050701092444.GA4317@janus>
	<E1DoIjd-0002bM-00@dorka.pomaz.szeredi.hu> <20050701120028.GB5218@janus>
	<E1DoKko-0002ml-00@dorka.pomaz.szeredi.hu> <20050701130510.GA5805@janus>
	<E1DoLSx-0002sR-00@dorka.pomaz.szeredi.hu> <20050701152003.GA7073@janus>
	<E1DoOwc-000368-00@dorka.pomaz.szeredi.hu> <20050701180415.GA7755@janus>
X-Habeas-SWE-9: mark in spam to <http://www.habeas.com/report/>.
X-Habeas-SWE-8: Message (HCM) and not spam. Please report use of this
X-Habeas-SWE-7: warrant mark warrants that this is a Habeas Compliant
X-Habeas-SWE-6: email in exchange for a license for this Habeas
X-Habeas-SWE-5: Sender Warranted Email (SWE) (tm). The sender of this
X-Habeas-SWE-4: Copyright 2002 Habeas (tm)
X-Habeas-SWE-3: like Habeas SWE (tm)
X-Habeas-SWE-2: brightly anticipated
X-Habeas-SWE-1: winter into spring
Date: Fri, 01 Jul 2005 15:35:11 -0400
In-Reply-To: <20050701180415.GA7755@janus> (Frank van Maarseveen's message of
	"Fri, 1 Jul 2005 20:04:15 +0200")
Message-ID: <871x6ijp5c.fsf@jbms.ath.cx>
User-Agent: Gnus/5.110003 (No Gnus v0.3) Emacs/22.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Frank van Maarseveen <frankvm@frankvm.com> writes:

[snip]

> But put otherwise: is there a compelling reason to permit FUSE mounts on
> non-leaf nodes?

In my own use of FUSE, I have found it handy to stick mount scripts in
some of the directories that I use as FUSE mount points.

-- 
Jeremy Maitin-Shepard
