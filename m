Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270818AbTHQUTe (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 17 Aug 2003 16:19:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270821AbTHQUTe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Aug 2003 16:19:34 -0400
Received: from dsl093-172-075.pit1.dsl.speakeasy.net ([66.93.172.75]:28850
	"EHLO marta.kurtwerks.com") by vger.kernel.org with ESMTP
	id S270818AbTHQUTd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Aug 2003 16:19:33 -0400
Date: Sun, 17 Aug 2003 16:19:31 -0400
From: Kurt Wall <kwall@kurtwerks.com>
To: linux-kernel@vger.kernel.org
Subject: Re: make htmldocs is broken.
Message-ID: <20030817201931.GO25975@kurtwerks.com>
References: <200308170618.35939.rob@landley.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200308170618.35939.rob@landley.net>
User-Agent: Mutt/1.4i
X-Operating-System: Linux 2.4.21-krw
X-Woot: Woot!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoth Rob Landley:
> Standard Red Hat 9 install (with 2.6.0-test3-bk1), did a make htmldocs, and it 
> barfed like so:
> 
> >  DOCPROC Documentation/DocBook/parportbook.sgml
> >  FIG2PNG Documentation/DocBook/parport-share.png
> >/bin/sh: line 1: fig2dev: command not found
> >make[1]: *** [Documentation/DocBook/parport-share.png] Error 127
> 
> Does this command live on default installs of SuSE or debian or something?  
> (Or maybe it was in RH 7 or so and has been removed?)

Dunno about the other others, but Slackware installs fig2dev from
the transfig package.

Kurt
-- 
You are a very redundant person, that's what kind of person you are.
