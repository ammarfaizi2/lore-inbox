Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262440AbTJTIim (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Oct 2003 04:38:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262441AbTJTIil
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Oct 2003 04:38:41 -0400
Received: from sol.cc.u-szeged.hu ([160.114.8.24]:32241 "EHLO
	sol.cc.u-szeged.hu") by vger.kernel.org with ESMTP id S262440AbTJTIil
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Oct 2003 04:38:41 -0400
Date: Mon, 20 Oct 2003 10:38:39 +0200 (CEST)
From: Geller Sandor <wildy@petra.hos.u-szeged.hu>
To: Tomi Orava <Tomi.Orava@ncircle.nullnet.fi>
cc: linux-kernel@vger.kernel.org
Subject: Re: HighPoint 374
In-Reply-To: <48232.192.168.9.10.1066590873.squirrel@ncircle.nullnet.fi>
Message-ID: <Pine.LNX.4.58.0310201028260.15393@petra.hos.u-szeged.hu>
References: <00b801c3955c$7e623100$0514a8c0@HUSH>   
 <1066579176.7363.3.camel@milo.comcast.net><41102.192.168.9.10.1066584247.squirrel@ncircle.nullnet.fi>
    <yw1x3cdpgm46.fsf@users.sourceforge.net> <48232.192.168.9.10.1066590873.squirrel@ncircle.nullnet.fi>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 19 Oct 2003, Tomi Orava wrote:

> I'd be really interested to hear if anyone has a working system
> with kernel included drivers & HPT374-controller integrated in
> motherboard and using PATA-drives ?

I have an Epox 8k5a3+ with 2 Maxtor drives (80GB) connected. It't running
fine, from 2.4.18-ac* kernels (currently 2.4.23-pre7-pac2). I haven't seen
any problems, the disks are mirrored (md driver), ext3, reiserfs, xfs and jfs
filesystems are on the disks. (I have very bad experiences with HTP372 and
80GB Maxtor drives)

  Geller Sandor <wildy@petra.hos.u-szeged.hu>
