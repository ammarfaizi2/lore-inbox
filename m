Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261232AbUFMWWy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261232AbUFMWWy (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Jun 2004 18:22:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261347AbUFMWWy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Jun 2004 18:22:54 -0400
Received: from FW-30-241.go.retevision.es ([62.174.241.30]:26043 "EHLO
	mayhem.ghetto") by vger.kernel.org with ESMTP id S261232AbUFMWWw
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Jun 2004 18:22:52 -0400
Date: Mon, 14 Jun 2004 00:22:49 +0200
To: linux-kernel@vger.kernel.org
Subject: Re: ftp.kernel.org
Message-ID: <20040613222249.GA12722@larroy.com>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <Pine.GSO.4.33.0405280018250.14297-100000@sweetums.bluetronic.net> <20040528150119.GE18449@thunk.org> <20040528163234.GV2603@schnapps.adilger.int> <168FA640-B185-11D8-9291-000A958E35DC@fhm.edu> <c9b9sj$ccc$1@terminus.zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c9b9sj$ccc$1@terminus.zytor.com>
User-Agent: Mutt/1.5.5.1+cvs20040105i
From: piotr@larroy.com (Pedro Larroy)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 30, 2004 at 12:29:07AM +0000, H. Peter Anvin wrote:
> Followup to:  <168FA640-B185-11D8-9291-000A958E35DC@fhm.edu>
> By author:    Daniel Egger <degger@fhm.edu>
> In newsgroup: linux.dev.kernel
> > 
> > Actually I think this is *the* idea. Why not simply set up a
> > bittorrent tracker and have a distributed kernel.org
> > fileserving system? Instead of having links to http and ftp
> > sites there could be a torrent link as well. Several
> > OpenSource projects started distributing files with BT
> > already and it seems to work like a charm.
> > 
> 
> Because doing it with BitTorrent is a nightmare.  I posted a long list
> of the problems with BT for doing this to the BT mailing list and
> pretty much got told that there is no way to do what I'd want to do
> within BT.
> 
> Some of the people from the BT list have approached me about creating
> a new protocol - working name "Software Distribution Protocol"
> (SDP)... but it's a big job.
> 
> 	-hpa
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

Something is already beeing done, and it's called PDTP:

http://pdtp.org/


Regards.

-- 
Pedro Larroy Tovar | Linux & Network consultant |  piotr%member.fsf.org 

Software patents are a threat to innovation in Europe please check: 
	http://www.eurolinux.org/     
