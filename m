Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262277AbUKVS02@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262277AbUKVS02 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Nov 2004 13:26:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262287AbUKVS01
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Nov 2004 13:26:27 -0500
Received: from linux01.gwdg.de ([134.76.13.21]:29087 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S262315AbUKVSYx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Nov 2004 13:24:53 -0500
Date: Mon, 22 Nov 2004 19:24:50 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
cc: linux-kernel@vger.kernel.org, reiserfs-list@namesys.com
Subject: Re: file as a directory 
In-Reply-To: <200411221759.iAMHx7QJ005491@turing-police.cc.vt.edu>
Message-ID: <Pine.LNX.4.53.0411221922570.27104@yvahk01.tjqt.qr>
References: <2c59f00304112205546349e88e@mail.gmail.com>
 <200411221759.iAMHx7QJ005491@turing-police.cc.vt.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: 8BIT
To: unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>Go back and re-read the whole flame-fest, understand all the points
>raised, and let us know when you have a workable proposal.
>
>(Hint - "file as directory" broke a number of programs that didn't
>expect that a file *could* be a directory, when run on a reiser4
>filesystem...)

So let's keep it to reiser4 as to not wildly break programs running on other
filesystems used in "stable kernels". I'm saying that everybody who runs a R4
FS knows that apps might break, and thus is responsible for making them ready
for reiser4. (Or ask the prog's maintainer.)



Jan Engelhardt
-- 
Gesellschaft für Wissenschaftliche Datenverarbeitung
Am Fassberg, 37077 Göttingen, www.gwdg.de
