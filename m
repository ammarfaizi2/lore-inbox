Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262468AbUD2Crj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262468AbUD2Crj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Apr 2004 22:47:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262470AbUD2Cri
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Apr 2004 22:47:38 -0400
Received: from mail48-s.fg.online.no ([148.122.161.48]:17342 "EHLO
	mail48-s.fg.online.no") by vger.kernel.org with ESMTP
	id S262468AbUD2Crg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Apr 2004 22:47:36 -0400
From: Kenneth =?iso-8859-1?q?Aafl=F8y?= <keaafloy@online.no>
To: Ian Stirling <ian.stirling@mauve.plus.com>
Subject: Re: [PATCH] Blacklist binary-only modules lying about their license
Date: Thu, 29 Apr 2004 04:47:30 +0200
User-Agent: KMail/1.6.2
References: <Pine.LNX.4.44.0404281958310.19633-100000@chimarrao.boston.redhat.com> <4150E18A-9985-11D8-85DF-000A95BCAC26@linuxant.com> <40906A35.3090004@mauve.plus.com>
In-Reply-To: <40906A35.3090004@mauve.plus.com>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200404290447.30154.keaafloy@online.no>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 29 April 2004 04:36, you wrote:
> Marc Boucher wrote:
> > Hi Rik,
> >
> > Your new proposed message sounds much clearer to the ordinary mortal and
> > would imho be a significant improvement. Perhaps printing repetitive
> > warnings for identical $MODULE_VENDOR strings could also be avoided,
> > taking care of the redundancy/volume problem as well..
>
> Is this worth 100 or 200 bytes of code though?
> I'd have to say no.

1000-2000(?) instructions to display the message and some x(?) instructions to 
check if it's been reported before, yeah, i'd have to say no too. ;)

Kenneth
