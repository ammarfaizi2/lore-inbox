Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314222AbSDRI24>; Thu, 18 Apr 2002 04:28:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314244AbSDRI2z>; Thu, 18 Apr 2002 04:28:55 -0400
Received: from moutvdomng1.kundenserver.de ([212.227.126.181]:41959 "EHLO
	moutvdomng1.kundenserver.de") by vger.kernel.org with ESMTP
	id <S314222AbSDRI2z>; Thu, 18 Apr 2002 04:28:55 -0400
Date: Thu, 18 Apr 2002 10:11:52 +0200
From: Heinz Diehl <hd@cavy.de>
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCHSET] Linux 2.4.19-pre7-jam1
Message-ID: <20020418081152.GA559@chiara.cavy.de>
Mail-Followup-To: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.10.10204161720260.10691-100000@master.linux-ide.org> <20020417134004.GA2025@werewolf.able.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Organization: private site in Mannheim/Germany
X-PGP-Key: To get my public-key, send mail with subject 'get pgpkey'
User-Agent: Mutt/1.5.0i (Linux 2.4.19-pre6 i586)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed Apr 17 2002, J.A. Magallon wrote:

> Can it be related to my system getting hung on boot trying to do
> an hdparm ?

Yep, here it is exactly the same.

I also changed '#if 1' to '#if 0' as Andre mentioned but it has no effect,
my machine hangs at boot time....

-- 
# Heinz Diehl, 68259 Mannheim, Germany
