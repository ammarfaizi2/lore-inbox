Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932663AbVJGOV2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932663AbVJGOV2 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Oct 2005 10:21:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932666AbVJGOV2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Oct 2005 10:21:28 -0400
Received: from main.gmane.org ([80.91.229.2]:65248 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S932663AbVJGOV2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Oct 2005 10:21:28 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Giuseppe Bilotta <bilotta78@hotpop.com>
Subject: 'Undeleting' an open file
Date: Fri, 7 Oct 2005 16:14:27 +0200
Message-ID: <8qo997np4h6n.1ihs13ptrx2y2.dlg@40tude.net>
References: <4TiWy-4HQ-3@gated-at.bofh.it> <4U0XH-3Gp-39@gated-at.bofh.it> <E1EMutG-0001Hd-7U@be1.lrz> <87k6gsjalu.fsf@amaterasu.srvr.nix> <4343E611.1000901@perkel.com> <20051005144441.GC8011@csclub.uwaterloo.ca> <4343E7AC.6000607@perkel.com> <20051005153727.994c4709.fmalita@gmail.com> <43442D19.4050005@perkel.com> <Pine.LNX.4.58.0510052208130.4308@be1.lrz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-84-220-51-179.cust-adsl.tiscali.it
User-Agent: 40tude_Dialog/2.0.15.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 5 Oct 2005 23:05:34 +0200 (CEST), Bodo Eggert wrote:

> Files are deleted if the last reference is gone. If you play a music file
> and unlink it while it's playing, it won't be deleted untill the player
> closes the file, since an open filehandle is a reference.

BTW, I've always wondered: is there a way to un-unlink such a file?

-- 
Giuseppe "Oblomov" Bilotta

"I weep for our generation" -- Charlie Brown

