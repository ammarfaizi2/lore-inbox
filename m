Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291741AbSBXWvM>; Sun, 24 Feb 2002 17:51:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291759AbSBXWvH>; Sun, 24 Feb 2002 17:51:07 -0500
Received: from aaf16.warszawa.sdi.tpnet.pl ([217.97.85.16]:58886 "EHLO
	aaf16.warszawa.sdi.tpnet.pl") by vger.kernel.org with ESMTP
	id <S291741AbSBXWus>; Sun, 24 Feb 2002 17:50:48 -0500
Date: Sun, 24 Feb 2002 23:50:33 +0100
From: Dominik Mierzejewski <dominik@aaf16.warszawa.sdi.tpnet.pl>
To: linux-kernel@vger.kernel.org
Subject: Re: Problem compiling (linking) linux-2.4.18-rc4
Message-ID: <20020224225033.GB28657@rathann.rangers.eu.org>
In-Reply-To: <200202242212.g1OMCQZ10840@ip68-4-73-243.oc.oc.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200202242212.g1OMCQZ10840@ip68-4-73-243.oc.oc.cox.net>
User-Agent: Mutt/1.3.27i
X-Linux-Registered-User: 134951
X-Homepage: http://home.elka.pw.edu.pl/~dmierzej/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday, 24 February 2002, Meinhard E. Mayer wrote:
> I got the following link error message when compiling linux-2.4.18-rc4 :
[snip] 
> Apparently the latest patch (rc3->rc4) messed something up in fs.
> atomic_dec_and_loc occurs in 4 source files there.  

No problems here. Which binutils version are you using?
 
-- 
"The Universe doesn't give you any points for doing things that are easy."
        -- Sheridan to Garibaldi in Babylon 5:"The Geometry of Shadows"
Dominik 'Rathann' Mierzejewski <rathann(at)rangers.eu.org>
