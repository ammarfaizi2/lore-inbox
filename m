Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932461AbWITXCh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932461AbWITXCh (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Sep 2006 19:02:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932462AbWITXCh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Sep 2006 19:02:37 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:50116 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S932461AbWITXCg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Sep 2006 19:02:36 -0400
Date: Wed, 20 Sep 2006 16:02:25 -0700 (PDT)
From: Christoph Lameter <clameter@sgi.com>
To: Paul Jackson <pj@sgi.com>
cc: rohitseth@google.com, ckrm-tech@lists.sourceforge.net, devel@openvz.org,
       npiggin@suse.de, linux-kernel@vger.kernel.org
Subject: Re: [patch00/05]: Containers(V2)- Introduction
In-Reply-To: <20060920155815.33b03991.pj@sgi.com>
Message-ID: <Pine.LNX.4.64.0609201601450.1026@schroedinger.engr.sgi.com>
References: <1158718568.29000.44.camel@galaxy.corp.google.com>
 <Pine.LNX.4.64.0609200916140.30572@schroedinger.engr.sgi.com>
 <1158773208.8574.53.camel@galaxy.corp.google.com>
 <Pine.LNX.4.64.0609201035240.31464@schroedinger.engr.sgi.com>
 <1158775678.8574.81.camel@galaxy.corp.google.com> <20060920155815.33b03991.pj@sgi.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 20 Sep 2006, Paul Jackson wrote:

> the kernel.  A useful memory containerization should (IMHO) allow for
> both adding and removing such containers.

How does the containers implementation under discussion behave if a 
process is part of a container and the container is removed?

