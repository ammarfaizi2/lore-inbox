Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263256AbTANPHU>; Tue, 14 Jan 2003 10:07:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263291AbTANPHU>; Tue, 14 Jan 2003 10:07:20 -0500
Received: from 80-195-22-93.cable.ubr02.ed.blueyonder.co.uk ([80.195.22.93]:56449
	"EHLO sisko.scot.redhat.com") by vger.kernel.org with ESMTP
	id <S263256AbTANPHT>; Tue, 14 Jan 2003 10:07:19 -0500
Subject: Re: 2.4.21-pre3 - problems with ext3
From: "Stephen C. Tweedie" <sct@redhat.com>
To: Lukasz Trabinski <lukasz@wsisiz.edu.pl>
Cc: ext3 users list <ext3-users@redhat.com>, akpm@zip.com.au,
       Andreas Dilger <adilger@clusterfs.com>, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.51.0301141401260.6636@oceanic.wsisiz.edu.pl>
References: <Pine.LNX.4.51.0301141401260.6636@oceanic.wsisiz.edu.pl>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 14 Jan 2003 15:15:54 +0000
Message-Id: <1042557354.5427.164.camel@sisko.scot.redhat.com>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, 2003-01-14 at 13:15, Lukasz Trabinski wrote:

> Jan 14 12:53:52 oceanic kernel: Code: 0f 0b f9 00 f4 4f 8b f8 ff 43 08 89 d8 8b 5c 24 14 8b 74 24 

That's a BUG(), and you should have had some form of ext3 or jbd assert
failure in the logs just before this oops --- could you supply that,
please?

Thanks,
 Stephen

