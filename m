Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964792AbWADWNO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964792AbWADWNO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Jan 2006 17:13:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964811AbWADWNN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Jan 2006 17:13:13 -0500
Received: from a34-mta01.direcpc.com ([66.82.4.90]:58670 "EHLO
	a34-mta01.direcway.com") by vger.kernel.org with ESMTP
	id S964792AbWADWNL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Jan 2006 17:13:11 -0500
Date: Wed, 04 Jan 2006 17:12:48 -0500
From: Ben Collins <ben.collins@ubuntu.com>
Subject: Re: [PATCH 0/15] Ubuntu patch sync
In-reply-to: <20060104140627.1e89c185@dxpl.pdx.osdl.net>
To: Stephen Hemminger <shemminger@osdl.org>
Cc: linux-kernel@vger.kernel.org
Message-id: <1136412768.4430.28.camel@grayson>
Organization: Ubuntu Linux
MIME-version: 1.0
X-Mailer: Evolution 2.5.3
Content-type: text/plain
Content-transfer-encoding: 7BIT
References: <0ISL003P992UCY@a34-mta01.direcway.com>
 <20060104140627.1e89c185@dxpl.pdx.osdl.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-01-04 at 14:06 -0800, Stephen Hemminger wrote:
> On Wed, 04 Jan 2006 16:59:02 -0500
> Ben Collins <bcollins@ubuntu.com> wrote:
> 
> > These patches are just attempts to merge code from the ubuntu kernel tree.
> > This is most of the differences between our tree and stock code (not
> > necessarily all differences, since we do have a lot of external drivers
> > pulled in).
> 
> Why not submit them too?

Because neither I nor Ubuntu maintains them as upstream. I would rather
leave it to the upstream authors of those drivers (e.g. rt2400, rt2500,
unionfs, etc.) to submit their own code to Linus.

-- 
   Ben Collins <ben.collins@ubuntu.com>
   Developer
   Ubuntu Linux

