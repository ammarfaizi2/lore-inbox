Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262972AbVFXBQx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262972AbVFXBQx (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Jun 2005 21:16:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262975AbVFXBQx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Jun 2005 21:16:53 -0400
Received: from main.gmane.org ([80.91.229.2]:3790 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S262972AbVFXBQv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Jun 2005 21:16:51 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Hubert Chan <hubert@uhoreg.ca>
Subject: Re: -mm -> 2.6.13 merge status
Date: Thu, 23 Jun 2005 21:13:01 -0400
Message-ID: <87fyv8h80y.fsf@evinrude.uhoreg.ca>
References: <20050620235458.5b437274.akpm@osdl.org.suse.lists.linux.kernel> <p73d5qgc67h.fsf@verdi.suse.de>
 <42B86027.3090001@namesys.com> <20050621195642.GD14251@wotan.suse.de>
 <42B8C0FF.2010800@namesys.com> <84144f0205062223226d560e41@mail.gmail.com>
 <42BB0151.3030904@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: cpe0004e289e618-cm000f212c9dfc.cpe.net.cable.rogers.com
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Cancel-Lock: sha1:buGNKLnDk/aurgiEPcBt3I8rKSM=
Cc: reiserfs-list@namesys.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 23 Jun 2005 14:37:05 -0400, Jeff Mahoney <jeffm@suse.de> said:

> As someone who spends time debugging reiser3 issues, I've grown
> accustomed to the named assertions. They make discussing a particular
> assertion much more natural in conversation than file:line. It also
> makes difficult to reproduce assertions more trackable over time. The
> assertion number never changes, but the line number can with even the
> most trivial of patches.

How about something of the form "nikita-955(file:line)"?  Or the
reverse: "file:line(nikita-955)".  Would that keep everyone happy?

-- 
Hubert Chan <hubert@uhoreg.ca> - http://www.uhoreg.ca/
PGP/GnuPG key: 1024D/124B61FA
Fingerprint: 96C5 012F 5F74 A5F7 1FF7  5291 AF29 C719 124B 61FA
Key available at wwwkeys.pgp.net.   Encrypted e-mail preferred.

