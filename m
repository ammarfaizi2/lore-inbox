Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266330AbTBCNsp>; Mon, 3 Feb 2003 08:48:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266347AbTBCNso>; Mon, 3 Feb 2003 08:48:44 -0500
Received: from jaguar.mkp.net ([66.11.169.42]:54450 "EHLO jaguar.mkp.net")
	by vger.kernel.org with ESMTP id <S266330AbTBCNsn>;
	Mon, 3 Feb 2003 08:48:43 -0500
To: =?iso-8859-1?q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
Cc: Daniel Egger <degger@fhm.edu>, Pavel Machek <pavel@ucw.cz>,
       kernel list <linux-kernel@vger.kernel.org>
Subject: Re: Compactflash cards dying?
From: "Martin K. Petersen" <mkp@mkp.net>
Organization: mkp.net
References: <20030202223009.GA344@elf.ucw.cz> <1044232591.545.8.camel@sonja>
	<yq1smv6qfvc.fsf@austin.mkp.net>
	<20030203083910.GB2287@wohnheim.fh-wedel.de>
Date: 03 Feb 2003 08:58:33 -0500
In-Reply-To: <20030203083910.GB2287@wohnheim.fh-wedel.de>
Message-ID: <yq1n0ldqxdi.fsf@austin.mkp.net>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Jörn" == Jörn Engel <joern@wohnheim.fh-wedel.de> writes:

>> Note that CF cards do transparent wear averaging inside.  So it's
>> obviously not a million writes to the same physical spot.  Also,
>> most vendors claim they have spare blocks for relocating areas that
>> are completely worn out.

Jörn> This apears to be the same statement, except that Daniel forgot
Jörn> to add "per block".

They'd have to use really shitty flash parts to go as low as 100
writes per physical block.  Off by a couple of orders of magnitude.

-- 
Martin K. Petersen	Wild Open Source, Inc.
mkp@wildopensource.com	http://www.wildopensource.com/
