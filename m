Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264171AbTCXMau>; Mon, 24 Mar 2003 07:30:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264173AbTCXMau>; Mon, 24 Mar 2003 07:30:50 -0500
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:54696
	"EHLO irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S264171AbTCXMat>; Mon, 24 Mar 2003 07:30:49 -0500
Subject: Re: PROBLEM: linux-2.5.65-ac3 does not boot whith IDE-drivers
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Norbert Wolff <norbert_wolff@t-online.de>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20030324110824.1b419814.norbert_wolff@t-online.de>
References: <20030322140337.GA1193@brodo.de>
	 <1048350905.9219.1.camel@irongate.swansea.linux.org.uk>
	 <20030322162502.GA870@brodo.de>
	 <1048354921.9221.17.camel@irongate.swansea.linux.org.uk>
	 <20030323010338.GA886@brodo.de>
	 <1048434472.10729.28.camel@irongate.swansea.linux.org.uk>
	 <20030323145915.GA865@brodo.de>
	 <1048444868.10729.54.camel@irongate.swansea.linux.org.uk>
	 <20030323181532.GA6819@brodo.de> <20030323182554.GA1270@brodo.de>
	 <3E7E3248.7070307@portrix.net>
	 <20030324110824.1b419814.norbert_wolff@t-online.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1048514087.25140.0.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 24 Mar 2003 13:54:48 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2003-03-24 at 11:08, Norbert Wolff wrote:
> Hi !
> 
> I tried linux-2.5.65-ac3 with ide-disk and ide-scsi drivers both built in
> the Kernel.
> Two ide-disks attached to ide0, two CDROMS attached to ide1.
> Im using the sis5513-PCI-IDE-Driver, but configuring it out makes no difference.

See the -ac4 tree for a cleaner fix from Dominik
