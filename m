Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264339AbUBFMD0 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Feb 2004 07:03:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264372AbUBFMD0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Feb 2004 07:03:26 -0500
Received: from main.gmane.org ([80.91.224.249]:19927 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S264339AbUBFMDH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Feb 2004 07:03:07 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Juergen Stuber <stuber@loria.fr>
Subject: Re: usb mouse/keyboard problems under 2.6.2
Date: Fri, 06 Feb 2004 13:02:44 +0100
Message-ID: <86u124a00r.fsf@loria.fr>
References: <20040204174748.GA27554@yggdrasil.localdomain> <20040205142155.GA606@ucw.cz>
 <20040205160226.GA13471@yggdrasil.localdomain>
 <20040205230304.GA2195@yggdrasil.localdomain>
 <20040206011531.GA2084@yggdrasil.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: berthelemy-1-81-56-4-123.fbx.proxad.net
User-Agent: Gnus/5.1006 (Gnus v5.10.6) Emacs/20.7 (gnu/linux)
Cancel-Lock: sha1:K/S6Un9Nmi1lp3czsx+6lRiV9o4=
Cc: linux-usb-devel@lists.sourceforge.net,
       linux-usb-users@lists.sourceforge.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg Norris <haphazard@kc.rr.com> writes:
>
> The problem appears to have been introduced in 2.6.2-rc2.  Can anyone
> tell me how to find the individual patches which were added between
> -rc1 and -rc2?  I can diff the trees easily enough, of course, but it
> would be much easier if I had a collection of discrete patches to work
> with.

I don't know where to find individual patches, but you can break
it down a little further with the -rc1-bkN patches in the snapshot
or snapshot-old subdirectory.


Jürgen

-- 
Jürgen Stuber <stuber@loria.fr>
http://www.loria.fr/~stuber/

