Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262328AbVAKTLU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262328AbVAKTLU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jan 2005 14:11:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262337AbVAKTLT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jan 2005 14:11:19 -0500
Received: from linux01.gwdg.de ([134.76.13.21]:54163 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S262328AbVAKTLD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jan 2005 14:11:03 -0500
Date: Tue, 11 Jan 2005 20:10:58 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
cc: linux-kernel@vger.kernel.org
Subject: Re: Unable to burn DVDs
In-Reply-To: <Pine.LNX.4.60.0501111943500.8024@alpha.polcom.net>
Message-ID: <Pine.LNX.4.61.0501112008080.7967@yvahk01.tjqt.qr>
References: <41E2F823.1070608@apartia.fr> <Pine.LNX.4.61.0501110802180.8535@yvahk01.tjqt.qr>
 <41E41B32.9070206@apartia.fr> <Pine.LNX.4.60.0501111943500.8024@alpha.polcom.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Also there is packet cdrw/dvd+-rw driver in kernel now (2.6.10?) that permits

I've got susekotd-2.6.8-0, which is a 2.6.9-rc2 if I'm not mistaken. 

> you to mount normal filesystem (for example UDF, but FAT or ISO - readonly of

No, it's all read-write, see 
http://marc.theaimsgroup.com/?l=linux-kernel&m=110297545900945&w=2
(It's really readwrite, no "-o ro" done by user- or kernelspace)

> course or EXT2 or any other but better for your media without journal) on such
> device.



Jan Engelhardt
-- 
ENOSPC
